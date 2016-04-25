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

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(UsersTableViewCell), forIndexPath: indexPath) as! UsersTableViewCell
        cell.configure(cellModels[indexPath.row])
        return cell
    }
}
