//
//  ContactsViewController.swift
//  ContactsBook
//
//  Created by Damir Aliyev on 02.10.2022.
//

import Foundation
import UIKit

class ContactsViewController: UIViewController {
    let searchController = UISearchController()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
//        navigationController?.title = "Contacts"
       navigationItem.searchController = searchController
    }
}
