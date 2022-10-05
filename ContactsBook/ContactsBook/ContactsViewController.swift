//
//  ContactsViewController.swift
//  ContactsBook
//
//  Created by Damir Aliyev on 02.10.2022.
//

import Foundation
import UIKit


class ContactsViewController: UIViewController{
   
    
    let searchController = UISearchController()
    let tableView = UITableView()
    let newContactVC = NewContactVC()
    
    
    var contactsArray = [
        ContactModel(gender: "male", contactName: "Ronaldo", phoneNumber: "+77777777777"),
        ContactModel(gender: "female", contactName: "Margot Robbie", phoneNumber: "+77777777778"),
        ContactModel(gender: "male", contactName: "Fazilkhan", phoneNumber: "+77777777779")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavBar()
        setup()
        layout()
    }
    

    override func viewWillLayoutSubviews() {
        tableView.frame = view.bounds
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func setup() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.register(ContactCell.self, forCellReuseIdentifier: ContactCell.reuseID)
        tableView.rowHeight = 80
//        tableView.frame = view.bounds
    }
    
    func layout() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupNavBar() {
        navigationItem.searchController = searchController
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addContact))
        navigationItem.rightBarButtonItem = addButton
        
        navigationItem.leftBarButtonItem = .some(editButtonItem)
//        editButtonItem.action = #selector(enableEditButton)
    }

    @objc func addContact() {
        self.navigationController?.pushViewController(newContactVC, animated: false)
        newContactVC.newContactDelegate = self
    }
    
//    @objc func enableEditButton() {
//        self.tableView.isEditing = true
//    }
    
}

extension ContactsViewController: NewContactDelegate {
    func didSaveContact(name: String, number: String, gender: String) {
        print("HERE")
        print(gender)
        contactsArray.append(ContactModel(gender: gender, contactName: name, phoneNumber: number))
        tableView.reloadData()
    }
}

extension ContactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
//    editingStyle
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            contactsArray.remove(at: indexPath.row)
            tableView.reloadData()
        }
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
