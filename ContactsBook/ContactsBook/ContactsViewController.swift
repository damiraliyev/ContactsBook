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
    let tableView = UITableView()
    
    let contactsArray = [
        ContactModel(gender: "male", contactName: "Ronaldo", phoneNumber: "+77777777777"),
        ContactModel(gender: "female", contactName: "Margot Robbie", phoneNumber: "+77777777778"),
        ContactModel(gender: "male", contactName: "Fazilkhan", phoneNumber: "+77777777779")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.searchController = searchController
        
        setup()
        layout()
    }
    
    func setup() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.register(ContactCell.self, forCellReuseIdentifier: ContactCell.reuseID)
        tableView.rowHeight = 80
        tableView.frame = view.bounds
        
        
    }
    
    func layout() {
        view.addSubview(tableView)
        
    }
}

extension ContactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension ContactsViewController: UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.reuseID, for: indexPath) as! ContactCell
        cell.configureCell(model: contactsArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsArray.count
    }
}
