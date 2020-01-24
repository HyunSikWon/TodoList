//
//  TodoListTableViewController.swift
//  TodoList
//
//  Created by 원현식 on 2020/01/23.
//  Copyright © 2020 Hyunsik Won. All rights reserved.
//

import UIKit

class TodoListTableViewController: UITableViewController {
    
    var todos: [TodoItem] = [TodoItem(text: "test1"), TodoItem(text: "test2")]
    
    @IBOutlet var deleteButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "Todo-List"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = editButtonItem
        deleteButton.isEnabled = false
        
        //편집 모드에서 multi selection 가능하게 선택 동그라미 나옴.
        tableView.allowsMultipleSelectionDuringEditing = true
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell") as! TodoListTableViewCell
        cell.todoText.text = todos[indexPath.row].text
        cell.checkMarkLabel.text = ""
        return cell
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let removedCell = todos.remove(at: sourceIndexPath.row)
        todos.insert(removedCell, at: destinationIndexPath.row)
        tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        todos.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEditing {
            return
        } else {
            if let selectedCell = tableView.cellForRow(at: indexPath) as? TodoListTableViewCell {
                if todos[indexPath.row].checked {
                    selectedCell.checkMarkLabel.text = ""
                    todos[indexPath.row].toggle()
                } else {
                    selectedCell.checkMarkLabel.text = "✓"
                    todos[indexPath.row].toggle()
                }
                tableView.deselectRow(at: indexPath, animated: true)
            }
            
        }
    }
    
    // MARK: - Edit 모드
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        tableView.setEditing(tableView.isEditing, animated: true)
        if tableView.isEditing {
            deleteButton.isEnabled = true
        } else {
            deleteButton.isEnabled = false
        }
        
        
    }
    
    // MARK: - Edit 모드에서 삭제
    @IBAction func deleteButton(_ sender: Any) {
        if let selectedRows = tableView.indexPathsForSelectedRows {
            for indexPath in selectedRows {
                
                let rowToDelete = indexPath.row > todos.count - 1 ? todos.count - 1 : indexPath.row
                    
                todos.remove(at: rowToDelete)
                
            }
            tableView.beginUpdates()
            tableView.deleteRows(at: selectedRows, with: .automatic)
            tableView.endUpdates()
        }
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditItemSegue" {
            if let addEditTableViewController = segue.destination as? AddEditTableViewController {
                if let cell = sender as? TodoListTableViewCell,
                    let indexPath = tableView.indexPath(for: cell){
                    let item = todos[indexPath.row]
                    addEditTableViewController.itemToEdit = item
                    addEditTableViewController.delegate = self
                    
                }
            }
        } else if segue.identifier == "AddItemSegue" {
            if let addEditTableViewController = segue.destination as? AddEditTableViewController {
                addEditTableViewController.delegate = self

            }
        }
    }
    
    
}

// MARK: - extension
extension TodoListTableViewController: AddEditTableViewControllerDelegate {
    func addEditTableViewcontroller(controller: AddEditTableViewController, didFinishingAdding item: TodoItem) {
        navigationController?.popViewController(animated: true)
        
        todos.append(item)
        tableView.reloadData()
        
    }
    
    func addEditTableViewcontroller(controller: AddEditTableViewController,beforeEditing oldItem : TodoItem,didFinishingEditing newItem : TodoItem) {
        
        navigationController?.popViewController(animated: true)
        
        for todo in todos {
            if todo === oldItem {
                todo.text = newItem.text
            }
        }
        
        tableView.reloadData()
    }
    
}
