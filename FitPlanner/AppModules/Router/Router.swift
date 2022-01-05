//
//  Router.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/4/22.
//

import UIKit

/// Router is responsable for outsourcing basic navigation away from the ViewController
struct Router {
    
    /// Pushes a  view controller onto the receiver's stack and updates the display
    static func pushToController(
        navigation: UINavigationController?,
        vc: UIViewController
    ) {
        navigation!.pushViewController(vc, animated: true)
    }
    
    /// Pops the top view controller form teh navigation stack and updates the display
    static func popController(navigation: UINavigationController?) {
        navigation!.popViewController(animated: true)
    }
    
    /// Presents a view controller modaly
    static func presentController(
        from rootViewController: UIViewController?,
        to presentingViewController: UIViewController,
        presentationStyle: UIModalPresentationStyle = .fullScreen,
        animated: Bool
    ) {
        let nav = UINavigationController(rootViewController: presentingViewController)
        nav.modalPresentationStyle = presentationStyle
        rootViewController!.present(nav, animated: animated, completion: nil)
    }
    
    /// Dismisses the view controller that was presented modaly by a view controller
    static func dismissController(navigation: UINavigationController?) {
        navigation!.dismiss(animated: true, completion: nil)
    }
    
    static func dismissController(_ viewController: UIViewController?) {
        viewController!.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    static func pushToWorkoutPlan(from rootVC: UIViewController?, type: WorkoutPlanType) {
        let controller = WorkoutPlanVC(type: type)
        controller.hidesBottomBarWhenPushed = true
        rootVC?.navigationController!.pushViewController(controller, animated: true)
    }
}
