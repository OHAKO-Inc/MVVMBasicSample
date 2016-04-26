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
    @IBOutlet weak var userImageView: UIImageView!

    @IBAction func imageFetchButtonTapped(sender: AnyObject) {
        viewModel.imageFetchButtonTapped()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = viewModel.fullName

        viewModel.imageDidSetClosure = { [weak self] (image) -> () in
            self?.userImageView.image = image
        }
    }

    deinit {
        print("UserViewController deinit")
    }

}
