//
//  UsersTableViewDataSource.swift
//  MVVMBasicSample
//
//  Created by Yoshikuni Kato on 2016/04/22.
//  Copyright © 2016年 Ohako Inc. All rights reserved.
//

import UIKit

class UsersTableViewDataSource: NSObject {
    var cellModels = [UsersTableCellModelType]()
}

extension UsersTableViewDataSource: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: UsersTableViewCell.self),
            for: indexPath
            ) as! UsersTableViewCell // swiftlint:disable:this force_cast
        cell.configure(with: cellModels[indexPath.row])
        return cell
    }
}
