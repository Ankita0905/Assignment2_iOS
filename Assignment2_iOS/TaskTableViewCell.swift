//
//  TaskTableViewCell.swift
//  Assignment2_iOS
//
//  Created by Ankita Jain on 2020-01-21.
//  Copyright © 2020 Ankita Jain. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    
    
           @IBOutlet weak var completedIMG: UIButton!
           @IBOutlet weak var titleLbl: UILabel!
           @IBOutlet weak var DaysLbl: UILabel!
           
           
           
           
           override func awakeFromNib() {
               super.awakeFromNib()
               
           }

           override func setSelected(_ selected: Bool, animated: Bool) {
               super.setSelected(selected, animated: animated)

           }

      
       }
