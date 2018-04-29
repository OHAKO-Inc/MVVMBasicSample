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
    var image: UIImage? { get }
    func imageFetchButtonTapped()
}

class UserViewModel: UserViewModelProtocol {

    let user: User

    let fullName: String
    var image: UIImage? {
        didSet {
            imageDidSetClosure?(image)
        }
    }
    var imageDidSetClosure: ((UIImage?) -> Void)? // "reference-cycle smell"

    func imageFetchButtonTapped() {
        // actually, some network requests
        let delay = 1.0 * Double(NSEC_PER_SEC)
        let time  = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time) { [weak self] in
            guard let unwrappedSelf = self else {
                return
            }
            unwrappedSelf.image = UIImage(named: unwrappedSelf.user.imageName)
            return
        }
    }

    init(user: User) {
        self.user = user
        fullName = "\(user.firstName) \(user.lastName)"
    }

    deinit {
        print("UserViewModel deinit")
    }

}
