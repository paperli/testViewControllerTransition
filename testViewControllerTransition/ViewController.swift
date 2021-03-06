//
//  ViewController.swift
//  testViewControllerTransition
//
//  Created by Paper Lee on 09/10/2017.
//  Copyright © 2017 paperworkStudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let presentAnimationController = PresentAnimationController()
    private let dismissAnimationController = DismissAnimationController()
    private let swipeInteractionController = SwipeInteractionController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toVC" {
            if let destinationVC = segue.destination as? DetailViewController {
                //destinationVC.transitioningDelegate = self
                swipeInteractionController.wireToViewController(viewController: destinationVC)
            }
        } else if segue.identifier == "toTVC" {
            // tableViewController
            if let destinationVC = segue.destination as? DetailTableViewController {
                //destinationVC.transitioningDelegate = self
                swipeInteractionController.wireToViewController(viewController: destinationVC)
            }
        }
        
    }*/
    
}

/*extension ViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentAnimationController
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissAnimationController
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return swipeInteractionController.interactionInProgress ? swipeInteractionController : nil
    }
}*/
