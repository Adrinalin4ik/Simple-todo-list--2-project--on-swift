//
//  Project.swift
//  taks4_project
//
//  Created by Employee on 11/11/15.
//  Copyright © 2015 adrinalin4ik. All rights reserved.
//

import Foundation


final class Project: ResponseCollectionSerializable{
    
    let id: Int
    let title: String
    let created_at: String
    let updated_at: String
    
    
    @objc required init?(response responce:NSHTTPURLResponse,representation: AnyObject){
        id = representation.valueForKeyPath("id") as! Int
        title = representation.valueForKeyPath("title") as! String
        created_at = representation.valueForKeyPath("created_at") as! String
        updated_at = representation.valueForKeyPath("updated_at") as! String
        
    }
    
    class func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [Project] {
        
      //  let array = representation as! [AnyObject]
        
      //  return array.map({Project(response: response, representation: $0)! })
        
        var projects:Array<Project> = Array<Project>()
        
        if let representation = representation as? [AnyObject] {
            for projectRepresentation in representation {
                if let project = Project(response: response, representation: projectRepresentation) {
                    projects.append(project)
                }
            }
        }
        
        return projects
    }
}