//
//  UsersViewController.swift
//  MVVMBasicSample
//
//  Created by Yoshikuni Kato on 2016/04/22.
//  Copyright © 2016年 Ohako Inc. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {

    var viewModel: UsersViewModel! {
        didSet {
            dataSource.cellModels = viewModel.cellModels
            tableView?.reloadData()
        }
    }

    fileprivate let dataSource = UsersTableViewDataSource()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
}
