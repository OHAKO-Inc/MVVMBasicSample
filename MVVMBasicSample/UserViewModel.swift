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

struct UserViewModel: UserViewModelProtocol {
    
    let fullName: String
    let age: String
    var image: UIImage?
    
    init(user: User) {
        fullName = "\(user.firstName) \(user.lastName)"
        age = "\(user.age)歳"
    }
}
