//
//  ListInforTableViewCell.swift
//  DemoLessonSix
//
//  Created by VietPhan on 9/6/19.
//  Copyright © 2019 Phan Thanh Việt. All rights reserved.
//

import UIKit

class ListInforTableViewCell: UITableViewCell {

    static let indentifier = "ListInforTableViewCell"
// MARK: - IBOutLet
    @IBOutlet weak var IDLable: UILabel!
    @IBOutlet weak var ContentLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
