//
//  Todo.swift
//  taks4_project
//
//  Created by Employee on 11/11/15.
//  Copyright © 2015 adrinalin4ik. All rights reserved.
//

import Foundation


final class Todo:ResponseCollectionSerializable{
    let id: Int
    let text:String
    var isCompleted: Bool = false
    let project_id: Int
    let created_at: String
    let updated_at: String
    
  
    
    @objc  required init?(response responce: NSHTTPURLResponse, representation: AnyObject){
        
        id = representation.valueForKeyPath("id") as! Int
        text = representation.valueForKeyPath("text") as! String
    
        self.isCompleted =  representation.valueForKeyPath("isCompleted") as! Bool
            
        
 
        project_id = representation.valueForKeyPath("project_id") as! Int
        created_at = representation.valueForKeyPath("created_at") as! String
        updated_at = representation.valueForKeyPath("updated_at") as! String
        
    }
    
    class func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [Todo] {
        var todos:Array<Todo> = Array<Todo>()
        
        if let representation = representation as? [AnyObject] {
            for todoRepresentation in representation {
                if let todo = Todo(response: response, representation: todoRepresentation) {
                    todos.append(todo)
                }
            }
        }
        
        return todos
    }
}