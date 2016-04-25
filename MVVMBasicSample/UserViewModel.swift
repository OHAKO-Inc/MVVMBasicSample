//
//  UserViewModel.swift
//  MVVMBasicSample
//
//  Created by Yoshikuni Kato on 2016/04/22.
//  Copyright © 2016年 Ohako Inc. All rights reserved.
//

import UIKit

protocol UserViewModelProtocol {
    var fullName: String { get }
    var age: String { get }
    var image: UIImage? { get }
}

class UserViewModel: UserViewModelProtocol {

    let fullName: String
    let age: String
    var image: UIImage? {
        didSet {
            imageDidSetClosure?(image)
        }
    }

    var imageDidSetClosure: ((UIImage?) -> ())?

    init(user: User) {
        fullName = "\(user.firstName) \(user.lastName)"
        age = "\(user.age)歳"

        // some network requests
        let delay = 3.0 * Double(NSEC_PER_SEC)
        let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) { [weak self] () -> () in
            self?.image = UIImage(named: user.imageName)
        }
    }

    deinit {
        print("UserViewModel deinit")
    }

}
