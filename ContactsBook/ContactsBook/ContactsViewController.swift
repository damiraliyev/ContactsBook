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
    
    let noContactsLabel = UILabel()
    
    var selectedContactIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        view.backgroundColor = .systemBackground
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.largeTitleDisplayMode = .always
        setupNavBar()
        setup()
        layout()
        
        loadContacts()
        
        hideOrShowNoContact()
       
    }
    
    

    override func viewWillLayoutSubviews() {
        tableView.frame = view.bounds
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),

        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.largeTitleDisplayMode = .always
    }
    
    func setup() {
        
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.register(ContactCell.self, forCellReuseIdentifier: ContactCell.reuseID)
        tableView.rowHeight = 80
//        tableView.frame = view.bounds
        
        noContactsLabel.translatesAutoresizingMaskIntoConstraints = false
        noContactsLabel.text = "No contacts"
        noContactsLabel.adjustsFontSizeToFitWidth = true
        noContactsLabel.textColor = .label
        noContactsLabel.font = UIFont.systemFont(ofSize: 20)
        noContactsLabel.isHidden = true
    }
    
    func layout() {
        view.addSubview(noContactsLabel)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            noContactsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            noContactsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
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
        searchController.searchBar.delegate = self
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
    
    func loadContacts(request:NSFetchRequest<Contact> = Contact.fetchRequest()) {
//        let request: NSFetchRequest<Contact> = Contact.fetchRequest()
        do {
            contactsArray = try context.fetch(request)
        } catch {
            print("Error fetching request: \(error)")
        }
        
    }
    
    func hideOrShowNoContact() {
        if contactsArray.count == 0 {
            print("here")
            noContactsLabel.isHidden = false
            tableView.isHidden = true
        } else {
            noContactsLabel.isHidden = true
            tableView.isHidden = false
        }
    }
    
}

extension ContactsViewController: NewContactDelegate {
    func didSaveContact(name: String, number: String, gender: String) {

        let newContact = Contact(context: context)
        newContact.contactName = name
        newContact.phoneNumber = number
        newContact.gender = gender
        contactsArray.append(newContact)
        saveContact()
        hideOrShowNoContact()
    }
    
   
}

extension ContactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let concatInfoVC = ContactInfoVC()
        let currentContact = contactsArray[indexPath.row]
        selectedContactIndex = indexPath.row
        concatInfoVC.setContactInfo(gender:currentContact.gender! , name: currentContact.contactName!, number: currentContact.phoneNumber!)
        concatInfoVC.deleteDelegate = self
        self.navigationController?.pushViewController(concatInfoVC, animated: false)
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
            hideOrShowNoContact()
            
            
        }
    }
    
    
    
}

extension ContactsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.reuseID, for: indexPath) as! ContactCell
        cell.configureCell(model: contactsArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contactsArray.count
    }
    
}


extension ContactsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            print("Here")
            loadContacts()
            tableView.reloadData()
//            searchBar.resignFirstResponder()
        } else {
            let request: NSFetchRequest<Contact> = Contact.fetchRequest()
            request.predicate = NSPredicate(format: "contactName CONTAINS[cd] %@", searchBar.text!)
            request.sortDescriptors = [NSSortDescriptor(key: "contactName", ascending: true)]
            loadContacts(request: request)
            
            tableView.reloadData()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        loadContacts()
        tableView.reloadData()
    }
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request: NSFetchRequest<Contact> = Contact.fetchRequest()
//        print(contactsArray[0].contactName)
//        request.predicate = NSPredicate(format: "contactName CONTAINS[cd] %@", searchBar.text!)
//        request.sortDescriptors = [NSSortDescriptor(key: "contactName", ascending: true)]
//        print(searchBar.text)
//
//        loadContacts(request: request)
//
//        tableView.reloadData()
//
//    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
               print("Called")
    }
}



extension ContactsViewController: DeleteContactDelegate {
    func didDelete() {
        print(selectedContactIndex)
        context.delete(contactsArray[selectedContactIndex])
        contactsArray.remove(at: selectedContactIndex)
        saveContact()
        hideOrShowNoContact()
    }
}
