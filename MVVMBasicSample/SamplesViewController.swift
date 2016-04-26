//
//  SamplesViewController.swift
//  MVVMBasicSample
//
//  Created by Yoshikuni Kato on 2016/04/25.
//  Copyright © 2016年 Ohako Inc. All rights reserved.
//

import UIKit

class SamplesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
}

extension SamplesViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        if let sample = MVVMSample(indexPath: indexPath) {
            cell.textLabel?.text = sample.title
        }
        return cell
    }

}

extension SamplesViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let sample = MVVMSample(indexPath: indexPath) else {
            return
        }


        switch sample {
        case .ViewWithoutMutableProperty:

            let user = User(firstName: "Emma", lastName: "Bradley", age: 27, imageName: "")
            let viewModel = UserNameViewModel(user: user)
            let userNameViewController = UIStoryboard(name: String(UserNameViewController), bundle: nil).instantiateInitialViewController() as! UserNameViewController
            userNameViewController.viewModel = viewModel
            self.navigationController?.pushViewController(userNameViewController, animated: true)


        case .TableViewWithoutMutableProperty:

            let users = [
                User(firstName: "Emma", lastName: "Bradley", age: 27, imageName: "yoshikuni"),
                User(firstName: "Alice", lastName: "Baker", age: 51, imageName: "yoshikuni"),
                User(firstName: "Edward", lastName: "Diaz", age: 10, imageName: "yoshikuni")
            ]

            let cellModels: [UsersTableCellModelType] = users.map { (user) -> UsersTableCellModel in
                return UsersTableCellModel(user: user)
            }

            let usersViewModel = UsersViewModel(cellModels: cellModels)
            let usersViewController = UIStoryboard(name: String(UsersViewController), bundle: nil).instantiateInitialViewController() as! UsersViewController
            usersViewController.viewModel = usersViewModel

            self.navigationController?.pushViewController(usersViewController, animated: true)


        case .ViewWithMutablePropertyUsingClosureForBinding:

            let user = User(firstName: "Yoshikuni", lastName: "Kato", age: 27, imageName: "yoshikuni")
            let userViewModel = UserViewModel(user: user)

            let userViewController = UIStoryboard(name: String(UserViewController), bundle: nil).instantiateInitialViewController() as! UserViewController
            userViewController.viewModel = userViewModel

            self.navigationController?.pushViewController(userViewController, animated: true)


           
        case .ViewWithMutablePropertyUsingRACForBinding:
            
            let user = User(firstName: "Yoshikuni", lastName: "Kato", age: 27, imageName: "yoshikuni")
            let userViewModel = UserViewModelWithRAC(user: user)
            
            let userViewController = UIStoryboard(name: String(UserViewControllerWithRAC), bundle: nil).instantiateInitialViewController() as! UserViewControllerWithRAC
            userViewController.viewModel = userViewModel
            
            self.navigationController?.pushViewController(userViewController, animated: true)
            
            
            break
        }
    }
}

enum MVVMSample {
    case ViewWithoutMutableProperty
    case TableViewWithoutMutableProperty
    case ViewWithMutablePropertyUsingClosureForBinding
    case ViewWithMutablePropertyUsingRACForBinding

    init?(indexPath: NSIndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            self = .ViewWithoutMutableProperty
        case (0, 1):
            self = .TableViewWithoutMutableProperty
        case (0, 2):
            self = .ViewWithMutablePropertyUsingClosureForBinding
        case (0, 3):
            self = .ViewWithMutablePropertyUsingRACForBinding
        default:
            return nil
        }
    }

    var title: String {
        switch self {
        case .ViewWithoutMutableProperty:
            return "View without mutable property"
        case .TableViewWithoutMutableProperty:
            return "TableView without mutable property"
        case .ViewWithMutablePropertyUsingClosureForBinding:
            return "View with mutable property. Using swift closure for binding."
        case .ViewWithMutablePropertyUsingRACForBinding:
            return "View with mutable property. Using ReactiveCocoa for binding."
        }
    }

}

// User Names were generated at http://uinames.com/
