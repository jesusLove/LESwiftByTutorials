//
//  LEDetailViewController.swift
//  LESwiftDemo
//
//  Created by LQQ on 2019/1/17.
//  Copyright © 2019 LQQ. All rights reserved.
//

import UIKit

class LEDetailViewController: UIViewController {
    public var todo: LETodoItem?
    
    @IBOutlet weak var childBtn: UIButton!
    @IBOutlet weak var cartBtn: UIButton!
    @IBOutlet weak var travelBtn: UIButton!
    @IBOutlet weak var phoneBtn: UIButton!
    @IBOutlet weak var titleLB: UITextField!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let todo = todo {
            title = "Edit Todo"
            if todo.image == "child-selected"{
                childBtn.isSelected = true
            }
            else if todo.image == "phone-selected"{
                phoneBtn.isSelected = true
            }
            else if todo.image == "shopping-cart-selected"{
                cartBtn.isSelected = true
            }
            else if todo.image == "travel-selected"{
                travelBtn.isSelected = true
            }
            titleLB.text = todo.title
            timePicker.setDate(todo.date, animated: true)
        } else {
            title = "New Todo"
            childBtn.isSelected = true
        }
    }
    func resetBtns() {
        childBtn.isSelected = false
        phoneBtn.isSelected = false
        cartBtn.isSelected = false
        travelBtn.isSelected = false
    }
    
    @IBAction func selectChild(_ sender: Any) {
        resetBtns()
        childBtn.isSelected = true
    }
    
    @IBAction func selectCart(_ sender: Any) {
        resetBtns()
        cartBtn.isSelected = true
    }
    
    @IBAction func selectTravel(_ sender: Any) {
        resetBtns()
        travelBtn.isSelected = true
    }
    @IBAction func selectPhone(_ sender: Any) {
        resetBtns()
        phoneBtn.isSelected = true
    }
    @IBAction func done(_ sender: Any) {
        var image = ""
        if childBtn.isSelected {
            image = "child-selected"
        }
        else if phoneBtn.isSelected {
            image = "phone-selected"
        }
        else if cartBtn.isSelected {
            image = "shopping-cart-selected"
        }
        else if travelBtn.isSelected {
            image = "travel-selected"
        }
        if let todo = todo {
            todo.image = image
            todo.title = titleLB.text!
            todo.date = timePicker.date
        } else {
            let uuid = UUID().uuidString
            todo = LETodoItem(id: uuid, image: image, title: titleLB.text!, date: timePicker.date)
            todoItems.append(todo!)
        }
        navigationController?.popViewController(animated: true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        // 点击屏幕结束编辑
        view.endEditing(true)
    }
}
