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
        newRecent.date = Date.now
        recents.insert(newRecent, at: 0)
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
//        let sort: NSSortDescriptor = NSSortDescriptor(key: "date", ascending: false)
//        request.sortDescriptors = [sort]
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
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context.delete(recents[indexPath.row])
            recents.remove(at: indexPath.row)
            saveRecent()
        }
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
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d HH:mm"
        if let date = recents[indexPath.row].date {
            content.secondaryText = dateFormatter.string(from: date)
            
        }
        cell.contentConfiguration = content
        return cell
    }
    
    
}


