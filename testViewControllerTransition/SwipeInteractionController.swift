//
//  SwipeInteractionController.swift
//  testViewControllerTransition
//
//  Created by Paper Lee on 09/10/2017.
//  Copyright © 2017 paperworkStudio. All rights reserved.
//

import UIKit

class SwipeInteractionController: UIPercentDrivenInteractiveTransition {
    
    let SWIPE_MARGIN = CGFloat(UIScreen.main.bounds.height)
    
    var interactionInProgress = false
    private var shouldCompleteTransition = false
    private weak var viewController: UIViewController!
    
    func wireToViewController(viewController: UIViewController!) {
        self.viewController = viewController
    }
    
    func new_scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // TODO
        interactionInProgress = true
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func new_scrollViewDidScroll(_ scrollView: UIScrollView) {
        // TODO
        let offset = scrollView.contentOffset
        var progress = fabs(offset.y) / SWIPE_MARGIN
        progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))
        
        shouldCompleteTransition = progress > 0.5
        update(progress)
    }
    
    func new_scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // TODO
        print("scrollViewWillEndDragging")
        interactionInProgress = false
        
        if shouldCompleteTransition {
            finish()
        } else {
            cancel()
        }
    }
}
