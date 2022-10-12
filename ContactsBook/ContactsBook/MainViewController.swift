//
//  ViewController.swift
//  ContactsBook
//
//  Created by Damir Aliyev on 02.10.2022.
//

import UIKit

class MainViewController: UITabBarController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        delegate = self

        setupTabBar()
    }
    
    func setupTabBar() {
        
        
        let recentsVC = RecentsViewController()
        recentsVC.tabBarItem = UITabBarItem(title: "Recents", image: UIImage(systemName: "clock.fill"), selectedImage: nil)
        
        let contactsVC = ContactsViewController()
        contactsVC.tabBarItem = UITabBarItem(title: "Contacts", image: UIImage(systemName: "person.crop.circle"), selectedImage: nil)
        
        let recentsNC = UINavigationController(rootViewController: recentsVC)
        let contactsNC = UINavigationController(rootViewController: contactsVC)
        
        
        recentsNC.navigationBar.prefersLargeTitles = true
        contactsNC.navigationBar.prefersLargeTitles = true
        
    
        recentsVC.navigationItem.title = "Recents"
        contactsVC.navigationItem.title = "Contacts"
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .systemBackground
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()

        contactsNC.navigationBar.scrollEdgeAppearance = appearance
        recentsNC.navigationBar.scrollEdgeAppearance = appearance
       
        contactsVC.navigationItem.searchController = UISearchController()
        
        viewControllers = [contactsNC, recentsNC]
        
        loadAllControllers()
       
    }
    
    func loadAllControllers() {
        if let viewControllers = self.viewControllers {
            for viewController in viewControllers {
                if let navVC = viewController as? UINavigationController {
                    print("true")
                    let _ = navVC.viewControllers.first?.view
                }
               
            }
        }
    }


}


extension MainViewController: UITabBarControllerDelegate  {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
          return false // Make sure you want this as false
        }

        if fromView != toView {
          UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
        }

        return true
    }
}


