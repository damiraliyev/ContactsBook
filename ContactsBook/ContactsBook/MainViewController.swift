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
        view.backgroundColor = .orange
        delegate = self
        
        setupTabBar()
    }
    
    func setupTabBar() {
        let favoritesVC = FavoritesViewController()
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star.fill"), selectedImage: nil)
        
        let recentsVC = RecentsViewController()
        recentsVC.tabBarItem = UITabBarItem(title: "Recents", image: UIImage(systemName: "clock.fill"), selectedImage: nil)
        
        let contactsVC = ContactsViewController()
        contactsVC.tabBarItem = UITabBarItem(title: "Contacts", image: UIImage(systemName: "person.crop.circle"), selectedImage: nil)
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .systemBackground
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        
        viewControllers = [favoritesVC, recentsVC, contactsVC]
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


