//
//  TodoTextCell.swift
//  taks4_project
//
//  Created by Employee on 10/11/15.
//  Copyright © 2015 adrinalin4ik. All rights reserved.
//

import UIKit

class TodoTextCell: UITableViewCell{
    
    
    
    let textField = UITextField(frame: CGRectMake(10.0,10.0,390.0,30.0))

    
    override func awakeFromNib(){
        super.awakeFromNib()
        
        textField.placeholder = "Enter todo"
        textField.font = UIFont(name: "Arial", size: 16)
        textField.borderStyle = UITextBorderStyle.Line
        
        addSubview(textField)

        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
}