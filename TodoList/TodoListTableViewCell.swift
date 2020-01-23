//
//  TodoListTableViewCell.swift
//  TodoList
//
//  Created by 원현식 on 2020/01/23.
//  Copyright © 2020 Hyunsik Won. All rights reserved.
//

import UIKit

class TodoListTableViewCell: UITableViewCell {
    
    
    @IBOutlet var todoText: UILabel!
    @IBOutlet var checkMarkLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
