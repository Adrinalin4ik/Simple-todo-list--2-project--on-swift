//
//  TodoCell.swift
//  taks4_project
//
//  Created by Employee on 07/11/15.
//  Copyright © 2015 adrinalin4ik. All rights reserved.
//

import UIKit
import Alamofire

class TodosCell: UITableViewCell, M13CheckboxDelegate{
    
    
    var todoText: String = String("text")
    var todoId: Int = Int(1)
    var todoIsCompleted: Bool = Bool(false)
    
    override func awakeFromNib(){
        super.awakeFromNib()
        
        let checkBox: M13Checkbox = M13Checkbox(title: "00000000000000000000000000000000000000000000")
        
        
        
        
        checkBox.checkColor = UIColor(red: 1,green: 1,blue: 1, alpha: 1)//цвет галки
        checkBox.strokeColor = UIColor(red: 0.28,green: 0.58,blue: 0.81,alpha: 1)//цвет рамки
        checkBox.tintColor = UIColor(red: 0.28,green: 0.58,blue: 0.81,alpha: 1)//цвет внитри рамки
        checkBox.radius = 0.8 //border-radius
        
        checkBox.titleLabel.textColor = UIColor.blackColor()
        checkBox.titleLabel.text = todoText
        
        checkBox.checkAlignment = M13CheckboxAlignmentLeft
        checkBox.frame = CGRectMake(15,0, checkBox.frame.width, 50)
        checkBox.titleLabel.font = UIFont(name: UIFont.familyNames()[3], size: 20)
        
        if(todoIsCompleted){
            checkBox.checkState = M13CheckboxStateChecked
        }else{
            checkBox.checkState = M13CheckboxStateUnchecked
        }
        checkBox.delegate = self
   
        addSubview(checkBox)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func m13CheckboxStateChangeTo(state: M13CheckboxState) {
        let param = ["id":todoId]
        Alamofire.request(.POST,"https://task5todo.herokuapp.com/todo/"+String(todoId),parameters:param)
    }

    
    
}
