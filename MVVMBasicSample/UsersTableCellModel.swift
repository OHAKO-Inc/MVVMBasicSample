//
//  UsersTableCellModel.swift
//  MVVMBasicSample
//
//  Created by Yoshikuni Kato on 2016/04/22.
//  Copyright © 2016年 Ohako Inc. All rights reserved.
//

import Foundation

protocol UsersTableCellModelType {
    var fullname: String { get }
}

struct UsersTableCellModel: UsersTableCellModelType {
    
    let fullname: String
    
    init(user: User) {
        fullname = "\(user.firstName) \(user.lastName)"
    }
}
