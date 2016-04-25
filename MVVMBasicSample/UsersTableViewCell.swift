//
//  UsersTableViewCell.swift
//  MVVMBasicSample
//
//  Created by Yoshikuni Kato on 2016/04/25.
//  Copyright © 2016年 Ohako Inc. All rights reserved.
//

import UIKit

class UsersTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!

    func configure(cellModel: UsersTableCellModelType) {
        nameLabel.text = cellModel.fullname
    }
}
