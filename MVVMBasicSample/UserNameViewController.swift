//
//  UserNameViewController.swift
//  MVVMBasicSample
//
//  Created by Yoshikuni Kato on 2016/04/25.
//  Copyright © 2016年 Ohako Inc. All rights reserved.
//

import UIKit

class UserNameViewController: UIViewController {

    var viewModel: UserNameViewModelType!

    @IBOutlet weak var fullNameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        fullNameLabel.text = viewModel.fullName
    }

}
