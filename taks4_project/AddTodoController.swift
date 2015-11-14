//
//  AddTodoController.swift
//  taks4_project
//
//  Created by Employee on 10/11/15.
//  Copyright © 2015 adrinalin4ik. All rights reserved.
//

import UIKit
import Alamofire


class AddTodoController: UITableViewController{


    
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        

        if (sender === saveBtn){
            var todoText: String = "text"
            
            for case let textField as UITextField in todoTextCell.subviews{
                todoText = textField.text!
            }
            let params_include = ["title":projects[selectedCategoryId].title,"text":todoText]
            let params = ["project":params_include]
            Alamofire.request(.POST, "https://task5todo.herokuapp.com/project",parameters:params)
            
            let param = ["id":todos.count+1]
            Alamofire.request(.POST,"https://task5todo.herokuapp.com/todo/"+String(todos.count+1),parameters:param)
            //Alamofire.request(.POST,"https://task3todo.herokuapp.com/todo/"+String(todos.count+1),parameters:param)
            

            print("done")
        }
    }
    

    
    var projects:Array<Project> = Array<Project>()
    var todos:Array<Todo> = Array<Todo>()
    
    var selectedCategoryId:Int = 0
    
    var todoTextCell: UITableViewCell = UITableViewCell()
    /*
    var projects = [(title: "Family", todo: "Go to the cinema",isComplete: false, id: 0),
        (title: "Family", todo: "Meet son after school",isComplete: false, id: 0),
        (title: "Work", todo: "Call the boss",isComplete: true, id: 1),
        (title: "Work", todo: "Finished task",isComplete: false, id: 1),
        (title: "Other", todo: "Buy milk",isComplete: false, id: 2),
        (title: "Other", todo: "Choose a gift  for a friend's birthday",isComplete: true, id: 2)]
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    // projects  count
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : getProjectsTitles().count

        
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 50))
        let title: UILabel = UILabel();
        title.frame = CGRectMake(10, 0, 200, 50)
        title.font = UIFont(name: "Arial", size: 12)
        if (section == 0){
            title.text = "Задание".uppercaseString
        }else if (section == 1){title.text = "Категория".uppercaseString}
        
        
        view.addSubview(title)
        return view
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        //высота cell (непосредственно само todo)
        return 50
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        //высота заголовка (название проекта)
        return 50
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identyfy = "todoCell"
        
        
        
        if (indexPath.section == 0){
            todoTextCell = TodoTextCell()
            todoTextCell = tableView.dequeueReusableCellWithIdentifier(identyfy) as!  TodoTextCell
            return todoTextCell
            
        }else {
            let cell = UITableViewCell()
            cell.textLabel?.text = getProjectsTitles()[indexPath.row]
            return cell
        }
       
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
     return 2
        
    }
    
    func getProjectsTitles() -> Array<String>{
        var titles = Array<String>()
        
        for (var i = 0; i<projects.count;i++){
            titles.append(projects[i].title)
        }
        return Array(titles)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        if(indexPath.section == 1){
            selectedCategoryId = indexPath.row
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            if cell?.accessoryType == .Checkmark{
                cell?.accessoryType = .None
            }else{
                cell?.accessoryType = .Checkmark
            }
        }
    }
    

}