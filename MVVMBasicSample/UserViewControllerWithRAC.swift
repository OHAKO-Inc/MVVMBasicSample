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

    private var imageFetchCocoaAction: CocoaAction?

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = viewModel.fullName

        // image binding
        viewModel
            .image
            .signal
            .observeNext { [weak self] (image) in
                self?.userImageView.image = image
        }

        // button binding
        imageFetchCocoaAction = CocoaAction(viewModel.imageFetchAction, input: nil)
        imageFetchButton.addTarget(imageFetchCocoaAction, action: CocoaAction.selector, forControlEvents: .TouchDown)
        viewModel
            .imageFetchAction
            .enabled
            .producer
            .startWithNext { [weak self] (enabled) in
                self?.imageFetchButton.enabled = enabled
        }
        
    }

    deinit {
        print("UserViewControllerWithRAC deinit")
    }
}
