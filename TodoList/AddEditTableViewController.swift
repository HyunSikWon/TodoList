//
//  AddEditTableViewController.swift
//  TodoList
//
//  Created by 원현식 on 2020/01/23.
//  Copyright © 2020 Hyunsik Won. All rights reserved.
//

import UIKit

protocol AddEditTableViewControllerDelegate: class {
    
    func addEditTableViewcontroller(controller: AddEditTableViewController, didFinishingAdding item : TodoItem)
    
    func addEditTableViewcontroller(controller: AddEditTableViewController,beforeEditing oldItem : TodoItem, didFinishingEditing newItem : TodoItem)
    
}

class AddEditTableViewController: UITableViewController {
    
    var itemToEdit: TodoItem?
    var delegate: AddEditTableViewControllerDelegate?
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var doneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let todoItem = itemToEdit {
            navigationItem.title = "Edit Item"
            textField.text = todoItem.text
            doneButton.isEnabled = true
        } else {
            navigationItem.title = "Add Item"
            
        }
    }
    
    @IBAction func done(_ sender: Any) {
        if let todoItem = itemToEdit, let text = textField.text{
            todoItem.text = text
            delegate?.addEditTableViewcontroller(controller: self, beforeEditing: itemToEdit!, didFinishingEditing: todoItem)
        } else {
            guard let text = textField.text else { return }
            let newItem = TodoItem(text: text)
            delegate?.addEditTableViewcontroller(controller: self, didFinishingAdding: newItem)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //이전 화면에서 +눌렀을 때 이 화면이 나오자마자 키보드가 나오도록..
        textField.becomeFirstResponder()
    }
    
}

// 입력내용이 있을 때 button이 활성화 되도록함. storyboard에서 delegate 연결해줘야 함.
extension AddEditTableViewController : UITextFieldDelegate {
    
    //The text field calls this method whenever the user taps the return button.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // 화면에서 키보드 사라짐
        return false
    }
    
    //The text field calls this method whenever user actions cause its text to change.
    //For example, you could use this method to prevent the user from entering anything but numerical values.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let oldText = textField.text,
            let stringRange = Range(range, in: oldText ) else {
                return false
        }
        
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        if newText.isEmpty { // Add 버튼 disable default로 해야 동작이 된다.
            doneButton.isEnabled = false
        } else {
            doneButton.isEnabled = true
        }
        
        return true
        
    }
    
}
