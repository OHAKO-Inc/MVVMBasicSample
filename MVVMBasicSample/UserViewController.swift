//
//  UserViewController.swift
//  MVVMBasicSample
//
//  Created by Yoshikuni Kato on 2016/04/22.
//  Copyright © 2016年 Ohako Inc. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    var viewModel: UserViewModel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = viewModel.fullName
        ageLabel.text = viewModel.age
    }
    
}
