//
//  SwipeTableInteractionController.swift
//  testViewControllerTransition
//
//  Created by Paper Lee on 15/10/2017.
//  Copyright © 2017 paperworkStudio. All rights reserved.
//

import UIKit

class SwipeTableInteractionController: UIPercentDrivenInteractiveTransition {
    
    let SWIPE_MARGIN = CGFloat(UIScreen.main.bounds.height)
    
    var interactionInProgress = false
    private var shouldCompleteTransition = false
    private weak var viewController: UIViewController!
    
    func wireToViewController(viewController: UIViewController!) {
        self.viewController = viewController
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.handleGesture(_:)))
        viewController.view.addGestureRecognizer(gesture)
        gesture.delegate = viewController as? UIGestureRecognizerDelegate
    }
    
    func wireToTableViewController(viewController: UITableViewController!) {
        self.viewController = viewController
        let gesture = viewController.tableView.panGestureRecognizer
        gesture.addTarget(self, action: #selector(self.handleGesture(_:)))
        //gesture.delegate = viewController as? UIGestureRecognizerDelegate
    }
    
    private func prepareGestureRecongizerInView(view: UIView) {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.handleGesture(_:)))
        view.addGestureRecognizer(gesture)
        //gesture.delegate = self
        
    }
    
    @objc func handleGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: gestureRecognizer.view)
        var progress = translation.y / SWIPE_MARGIN
        progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))
        
        switch gestureRecognizer.state {
        case .began:
            // begin
            interactionInProgress = true
            viewController.dismiss(animated: true, completion: nil)
        case .changed:
            shouldCompleteTransition = progress > 0.5
            update(progress)
        case .cancelled:
            print("cancelled")
            interactionInProgress = false
            cancel()
        case .ended:
            print("ended")
            interactionInProgress = false
            
            if !shouldCompleteTransition {
                print("ended:cancel")
                cancel()
            } else {
                print("ended:finish")
                finish()
            }
        default:
            print("Unsupported")
        }
    }
    
}
