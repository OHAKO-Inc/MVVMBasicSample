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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if let sample = MVVMSample(indexPath: indexPath) {
            cell.textLabel?.text = sample.title
        }
        return cell
    }

}

extension SamplesViewController: UITableViewDelegate {
    // swiftlint:disable:next function_body_length
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
        ) {
        guard let sample = MVVMSample(indexPath: indexPath) else {
            return
        }

        switch sample {
        case .viewWithoutMutableProperty:

            let user = User(firstName: "Emma", lastName: "Bradley", age: 27, imageName: "")
            let viewModel = UserNameViewModel(user: user)
            let userNameViewController = UIStoryboard(
                name: String(describing: UserNameViewController.self),
                bundle: nil
                ).instantiateInitialViewController() as! UserNameViewController // swiftlint:disable:this force_cast
            userNameViewController.viewModel = viewModel

            self.navigationController?.pushViewController(userNameViewController, animated: true)

        case .tableViewWithoutMutableProperty:

            let users = [
                User(firstName: "Emma", lastName: "Bradley", age: 27, imageName: "yoshikuni"),
                User(firstName: "Alice", lastName: "Baker", age: 51, imageName: "yoshikuni"),
                User(firstName: "Edward", lastName: "Diaz", age: 10, imageName: "yoshikuni")
            ]
            let usersViewModel = UsersViewModel(cellModels: users.map(UsersTableCellModel.init))
            let usersViewController = UIStoryboard(
                name: String(describing: UsersViewController.self),
                bundle: nil
                ).instantiateInitialViewController() as! UsersViewController // swiftlint:disable:this force_cast
            usersViewController.viewModel = usersViewModel

            self.navigationController?.pushViewController(usersViewController, animated: true)

        case .viewWithMutablePropertyUsingClosureForBinding:

            let user = User(firstName: "Yoshikuni", lastName: "Kato", age: 27, imageName: "yoshikuni")
            let userViewModel = UserViewModel(user: user)
            let userViewController = UIStoryboard(
                name: String(describing: UserViewController.self),
                bundle: nil
                ).instantiateInitialViewController() as! UserViewController // swiftlint:disable:this force_cast
            userViewController.viewModel = userViewModel

            self.navigationController?.pushViewController(userViewController, animated: true)

        case .viewWithMutablePropertyUsingRACForBinding:

            let user = User(firstName: "Yoshikuni", lastName: "Kato", age: 27, imageName: "yoshikuni")
            let userViewModel = UserViewModelWithRAC(user: user)
            let userViewController = UIStoryboard(
                name: String(describing: UserViewControllerWithRAC.self),
                bundle: nil
                ).instantiateInitialViewController() as! UserViewControllerWithRAC // swiftlint:disable:this force_cast
            userViewController.viewModel = userViewModel

            self.navigationController?.pushViewController(userViewController, animated: true)

        }
    }
}

enum MVVMSample {
    case viewWithoutMutableProperty
    case tableViewWithoutMutableProperty
    case viewWithMutablePropertyUsingClosureForBinding // swiftlint:disable:this identifier_name
    case viewWithMutablePropertyUsingRACForBinding // swiftlint:disable:this identifier_name

    init?(indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            self = .viewWithoutMutableProperty
        case (0, 1):
            self = .tableViewWithoutMutableProperty
        case (0, 2):
            self = .viewWithMutablePropertyUsingClosureForBinding
        case (0, 3):
            self = .viewWithMutablePropertyUsingRACForBinding
        default:
            return nil
        }
    }

    var title: String {
        switch self {
        case .viewWithoutMutableProperty:
            return "View without mutable property"
        case .tableViewWithoutMutableProperty:
            return "TableView without mutable property"
        case .viewWithMutablePropertyUsingClosureForBinding:
            return "View with mutable property. Using swift closure for binding."
        case .viewWithMutablePropertyUsingRACForBinding:
            return "View with mutable property. Using ReactiveCocoa for binding."
        }
    }

}

// User Names were generated at http://uinames.com/
