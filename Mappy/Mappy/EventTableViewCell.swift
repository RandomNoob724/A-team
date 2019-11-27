//
//  EventTableViewCell.swift
//  Mappy
//
//  Created by Ulf Jesper Isacson on 2019-11-27.
//  Copyright © 2019 Emil Persson. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell
{
    @IBOutlet weak var titleForEvent: UILabel!
    @IBOutlet weak var dateForEvent: UILabel!
    @IBOutlet weak var timeForEvent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
