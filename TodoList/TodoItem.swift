//
//  TodoItem.swift
//  TodoList
//
//  Created by 원현식 on 2020/01/23.
//  Copyright © 2020 Hyunsik Won. All rights reserved.
//

import Foundation

class TodoItem {
    var text: String
    var checked = false
    
    init(text: String) {
        self.text = text
    }
    
    func toggle() {
        checked = !checked
    }
    
}
