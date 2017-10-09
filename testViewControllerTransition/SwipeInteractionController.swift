//
//  SwipeInteractionController.swift
//  testViewControllerTransition
//
//  Created by Paper Lee on 09/10/2017.
//  Copyright © 2017 paperworkStudio. All rights reserved.
//

import UIKit

class SwipeInteractionController: UIPercentDrivenInteractiveTransition {
    
    let SWIPE_MARGIN = CGFloat(200.0)
    
    var interactionInProgress = false
    private var shouldCompleteTransition = false
    private weak var viewController: UIViewController!
    
    func wireToViewController(viewController: UIViewController!) {
        self.viewController = viewController
        prepareGestureRecongizerInView(view: viewController.view)
    }
    
    private func prepareGestureRecongizerInView(view: UIView) {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.handleGesture(_:)))
        view.addGestureRecognizer(gesture)
        
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
