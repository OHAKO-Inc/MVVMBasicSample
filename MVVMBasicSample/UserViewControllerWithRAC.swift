//
//  UserViewControllerWithRAC.swift
//  MVVMBasicSample
//
//  Created by Yoshikuni Kato on 2016/04/25.
//  Copyright © 2016年 Ohako Inc. All rights reserved.
//

import UIKit
import ReactiveCocoa
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

        // image binding
        viewModel
            .image
            .signal
            .observeValues { [weak self] image in
                self?.userImageView.image = image
        }

        // button binding
        imageFetchCocoaAction = CocoaAction(viewModel.imageFetchAction, input: nil)
        imageFetchButton.addTarget(imageFetchCocoaAction, action: CocoaAction<Any>.selector, for: .touchDown)
        viewModel
            .imageFetchAction
            .isEnabled
            .producer
            .startWithValues { [weak self] enabled in
                self?.imageFetchButton.isEnabled = enabled
        }
        
    }

    deinit {
        print("UserViewControllerWithRAC deinit")
    }
}
