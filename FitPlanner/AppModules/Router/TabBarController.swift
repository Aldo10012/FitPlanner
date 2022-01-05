//
//  TabBarController.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/4/22.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStyles()
        setupVCs()
    }
    
    fileprivate func setupStyles() {
        view.backgroundColor = .systemBackground
        
        UITabBar.appearance().barTintColor = .systemBackground
        
//        tabBar.barTintColor = UIColor.red
        tabBar.tintColor = UIColor.FPBlue
        tabBar.unselectedItemTintColor = UIColor.gray
    }
    
    fileprivate func setupVCs() {
        viewControllers = [
            createNavController(for: HomeVC(),
                                navBarTitle: NSLocalizedString("Welcome", comment: ""),
                                tabBarTitle: NSLocalizedString("Home", comment: ""),
                                image: UIImage(systemName: "chart.bar")!,
                                selectedImage: UIImage(systemName: "chart.bar.fill")!),
            
            createNavController(for: WorkoutLogVC(),
                                navBarTitle: NSLocalizedString("Workout log", comment: ""),
                                tabBarTitle: NSLocalizedString("Create", comment: ""),
                                image: UIImage(systemName: "plus.circle")!,
                                selectedImage: UIImage(systemName: "plus.circle.fill")!),
            
            createNavController(for: ProfileVC(),
                                navBarTitle: NSLocalizedString("Profile", comment: ""),
                                tabBarTitle: NSLocalizedString("Home", comment: ""),
                                image: UIImage(systemName: "person")!,
                                selectedImage: UIImage(systemName: "person.fill")!)
        ]
        
    }
    
    fileprivate func createNavController(
        for rootViewController: UIViewController,
        navBarTitle: String,
        tabBarTitle: String,
        image: UIImage,
        selectedImage: UIImage) -> UIViewController
    {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = tabBarTitle
        navController.tabBarItem.image = image
        navController.tabBarItem.selectedImage = selectedImage
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = navBarTitle
        return navController
    }

}
