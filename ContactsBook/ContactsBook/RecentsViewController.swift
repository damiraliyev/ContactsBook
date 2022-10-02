//
//  RecentsViewController.swift
//  ContactsBook
//
//  Created by Damir Aliyev on 02.10.2022.
//

import Foundation
import UIKit

class RecentsViewController: UIViewController {
    let searchController = UISearchController()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
//        navigationController?.title = "Recents"
        navigationItem.searchController = searchController
    }
}
