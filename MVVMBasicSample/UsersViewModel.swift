//
//  UsersViewModel.swift
//  MVVMBasicSample
//
//  Created by Yoshikuni Kato on 2016/04/22.
//  Copyright © 2016年 Ohako Inc. All rights reserved.
//

import Foundation

protocol UsersViewModelType {
    var cellModels: [UsersTableCellModelType] { get }
}

struct UsersViewModel {

    let cellModels: [UsersTableCellModelType]

    init(cellModels: [UsersTableCellModelType]) {
        self.cellModels = cellModels
    }
}
