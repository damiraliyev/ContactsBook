//
//  ContactsViewController.swift
//  ContactsBook
//
//  Created by Damir Aliyev on 02.10.2022.
//

import Foundation
import UIKit
import CoreData


class ContactsViewController: UIViewController{
   
    
    let searchController = UISearchController()
    let tableView = UITableView()
    let newContactVC = NewContactVC()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var contactsArray = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        view.backgroundColor = .systemBackground
        setupNavBar()
        setup()
        layout()
        
        loadContacts()
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
    }

    @objc func addContact() {
        self.navigationController?.pushViewController(newContactVC, animated: false)
        newContactVC.newContactDelegate = self
    }
    
    //MARK: Function for save and fetch data from CoreData
    func saveContact() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadContacts() {
        let request: NSFetchRequest<Contact> = Contact.fetchRequest()
        do {
            contactsArray = try context.fetch(request)
        } catch {
            print("Error fetching request: \(error)")
        }
        
    }
    
//    @objc func enableEditButton() {
//        self.tableView.isEditing = true
//    }
    
}

extension ContactsViewController: NewContactDelegate {
    func didSaveContact(name: String, number: String, gender: String) {
        
//        let newContact = ContactModel(gender: gender, contactName: name, phoneNumber: number)
        let newContact = Contact(context: context)
        newContact.contactName = name
        newContact.phoneNumber = number
        newContact.gender = gender
        contactsArray.append(newContact)
        saveContact()
//        tableView.reloadData()
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
            context.delete(contactsArray[indexPath.row])
            contactsArray.remove(at: indexPath.row)
            saveContact()
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
