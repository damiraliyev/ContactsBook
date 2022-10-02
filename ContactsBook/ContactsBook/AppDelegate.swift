//
//  AppDelegate.swift
//  ContactsBook
//
//  Created by Damir Aliyev on 02.10.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    let navigationController = UINavigationController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = MainViewController()
        
//        setupNavController()
        
        return true
    }
    
    func setupNavController() {
        navigationController.viewControllers = [MainViewController()]
//        MainViewController().setupTabBar()
//        navigationController.navigationBar.prefersLargeTitles = true
        let appearance = UINavigationBarAppearance()

        appearance.configureWithOpaqueBackground()
        navigationController.navigationBar.scrollEdgeAppearance = appearance
//
    }



}


extension UIViewController {
    func setStatusBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground() // to hide Navigation Bar Line also
        navBarAppearance.backgroundColor = .systemRed
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
}
