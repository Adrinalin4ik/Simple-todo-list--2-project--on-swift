//
//  TodosController.swift
//  taks4_project
//
//  Created by Employee on 07/11/15.
//  Copyright © 2015 adrinalin4ik. All rights reserved.
//

import UIKit
import Alamofire


class TodosController: UITableViewController{
    

    @IBAction func back(segue: UIStoryboardSegue){
        self.dismissViewControllerAnimated(true, completion: nil)
       downloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        let navigationViewController = segue.destinationViewController as! UINavigationController
        let addTodoController = navigationViewController.topViewController as! AddTodoController
        addTodoController.projects = projects
        addTodoController.todos = todos
    }
    
       
    var projects:Array<Project> = Array<Project>()
    var todos:Array<Todo> = Array<Todo>()
    
    
    // test array
    /*var projects = [(title: "Family", todo: "Go to the cinema",isComplete: false, id: 0),
        (title: "Family", todo: "Meet son after school",isComplete: false, id: 0),
        (title: "Work", todo: "Call the boss",isComplete: true, id: 1),
        (title: "Work", todo: "Finished task",isComplete: false, id: 1),
        (title: "Other", todo: "Buy milk",isComplete: false, id: 2),
        (title: "Other", todo: "Choose a gift  for a friend's birthday",isComplete: true, id: 2)]
    */
    

    override func viewDidLoad() {
        
        // Do any additional setup after loading the view, typically from a nib.
        
             downloadData()
             super.viewDidLoad()
        
        
     
    }
    
    func downloadData(){
        ///Projects
        Alamofire.request(.GET, "https://task5todo.herokuapp.com/get_projects")
            
            .responseCollection{(response: Response<[Project],NSError>) in
                self.projects = response.result.value!
                
                //debugPrint(response)
        }
        ////////Todos
        Alamofire.request(.GET, "https://task5todo.herokuapp.com/get_todos")
            .responseCollection{(response: Response<[Todo],NSError>) in
                //todosResponse = response.result.value!
                //todos = sort(&todosResponse,sortTodos)
                self.todos = response.result.value!.sort({ $0.id < $1.id })
                //debugPrint(response)
                self.tableView.reloadData()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //возвращаем количество задач внутри проекта, который находим, используя section

        return getProjectTodos(section).count
        
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      /*  let view = UIView(frame: CGRectMake(0, 0, 200, 30))
        let title:UILabel = UILabel()
        title.text = getProjectsTitles()[section].uppercaseString
        title.frame = CGRectMake(0, 0, 200, 50)
        title.font = UIFont(name: UIFont.familyNames()[17], size: 15)
        
        
        
        
        view.addSubview(title)
        return view
*/
       let view = UIView(frame: CGRectMake(0, 0, tableView.frame.width, 30))
        let titleBackground: UILabel = UILabel(frame: CGRectMake(0, 0, view.frame.width, 30))
        let title:UILabel = UILabel(frame: CGRectMake(10, 0, view.frame.width, 30))
        title.text = getProjectsTitles()[section].uppercaseString
        //title.frame = CGRectMake(10, 0, 200, 50)
        //title.font = UIFont(name: UIFont.familyNames()[17], size: 12)
        titleBackground.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.2)
        
        title.font = UIFont(name: "Arial", size: 10)
        
        view.addSubview(titleBackground)
        view.addSubview(title)
        
        return view

        
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        //высота cell (непосредственно само todo)
        return 40
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        //высота заголовка (название проекта)
        return 50
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)-> UITableViewCell {
        
        let identify = "cell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(identify) as! TodosCell
        
        var todos = getProjectTodos(indexPath.section)
        let todo = todos[indexPath.row]
        cell.todoText = todo.text// get a todo text
        cell.todoId = todo.id
        for case let checkBox as M13Checkbox in cell.subviews {
            
            checkBox.titleLabel.text = todo.text
            checkBox.titleLabel.font = UIFont(name: "Arial", size: 16)
            
            if(todo.isCompleted){
                checkBox.checkState = M13CheckboxStateChecked
            }else{
                checkBox.checkState = M13CheckboxStateUnchecked
            }
            
           
        }
        
        
        
  
        
        
        
        return cell
        //находим cell, используя Identifier, который установили в storyboard, и возвращаем cell для текущего индекса
        
        //пока не нужно устанавливать текст, поскольку мы будем добавлять кастомный компонент - checkbox, а не UILabel, который установлен в стандартной UITableViewCell по умолчанию
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        //возвращаем количество секций (проектов)
       
        return getProjectsTitles().count
        
    }
    
    func getProjectsTitles() -> Array<String>{
        var titles = Array<String>()
        
        for (var i = 0; i<projects.count;i++){
            titles.append(projects[i].title)
        }
        return Array(titles)
    }
    
    func getProjectTodos(projectId:NSInteger)->Array<Todo>{
        //var todos = Array<String>()
        //for (var i=0;i<projects.count;i++){
        //    if (projects[i].title == getProjectsTitles()[projectId]){
        //        todos.append(todos[i].todo)
        //    }
        //}
        
        var todosArray = Array<Todo>()
        for (var i=0;i<self.todos.count;i++){
            if (todos[i].project_id == projectId+1){
                todosArray.append(todos[i])
            }
        }
        return todosArray
        
    }
    

    
}
