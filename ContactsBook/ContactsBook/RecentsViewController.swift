//
//  RecentsViewController.swift
//  ContactsBook
//
//  Created by Damir Aliyev on 02.10.2022.
//

import Foundation
import UIKit
import CoreData

class RecentsViewController: UIViewController {
    let contactInfoVC = ContactInfoVC()
    let searchController = UISearchController()
    var recents = [Recent]()
    let tableView = UITableView()
    
    var contactName = ""
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
//        navigationController?.title = "Recents"
        navigationItem.searchController = searchController
        print("viewDidLoad")
        setup()
        layout()
        loadRecents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setup() {
        
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        registerForNotifications()
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
    
    func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(callPressed), name: NSNotification.Name("Called"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(enteredToInfo), name: NSNotification.Name("EnteredToInfo"), object: nil)
    }
    
    @objc func enteredToInfo(_ notification: Notification) {
        contactName = notification.userInfo?["contactName"] as! String
    }
    
    @objc func callPressed(_ notification: Notification) {
        let newRecent = Recent(context: context)
        newRecent.contactName = contactName
        recents.append(newRecent)
        saveRecent()
        
    }
    
    //MARK: CoreData functions
    func saveRecent() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
        tableView.reloadData()
    }
    
    func loadRecents() {
        let request: NSFetchRequest<Recent> = Recent.fetchRequest()
        do {
            recents = try context.fetch(request)
        } catch {
            print("Error fetching request: \(error)")
        }
        tableView.reloadData()
    }
}

extension RecentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension RecentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = recents[indexPath.row].contactName
        cell.contentConfiguration = content
        return cell
    }
    
    
}


