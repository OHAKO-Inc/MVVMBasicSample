//
//  UserNameViewModel.swift
//  MVVMBasicSample
//
//  Created by Yoshikuni Kato on 2016/04/25.
//  Copyright © 2016年 Ohako Inc. All rights reserved.
//

import Foundation

protocol UserNameViewModelType {
    var fullName: String { get }
}

struct UserNameViewModel: UserNameViewModelType {
    let fullName: String
    init(user: User) {
        fullName = "\(user.firstName) \(user.lastName)"
    }
}
