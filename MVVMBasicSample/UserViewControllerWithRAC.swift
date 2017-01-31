//
//  UserViewControllerWithRAC.swift
//  MVVMBasicSample
//
//  Created by Yoshikuni Kato on 2016/04/25.
//  Copyright © 2016年 Ohako Inc. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

class UserViewControllerWithRAC: UIViewController {

    var viewModel: UserViewModelWithRAC!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var imageFetchButton: UIButton!

    fileprivate var imageFetchCocoaAction: CocoaAction<Any>?

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = viewModel.fullName

        userImageView.reactive.image <~ viewModel.image
        imageFetchButton.reactive.pressed = CocoaAction(viewModel.imageFetchAction)
    }

    deinit {
        print("UserViewControllerWithRAC deinit")
    }
}
