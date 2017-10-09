//
//  DismissAnimationController.swift
//  testViewControllerTransition
//
//  Created by Paper Lee on 09/10/2017.
//  Copyright © 2017 paperworkStudio. All rights reserved.
//

import UIKit

class DismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from), let toVC = transitionContext.viewController(forKey: .to) else {
            return
        }
        
        let blackBackgroundView = UIView()
        blackBackgroundView.frame = toVC.view.bounds
        blackBackgroundView.backgroundColor = UIColor.black
        blackBackgroundView.alpha = 0.5
        toVC.view.addSubview(blackBackgroundView)
        
        let containerView = transitionContext.containerView
        
        //let initialFrame = transitionContext.initialFrame(for: fromVC)
        
        let snapshot = fromVC.view.snapshotView(afterScreenUpdates: false)
        
        //containerView.addSubview(toVC.view)
        containerView.addSubview(snapshot!)
        fromVC.view.isHidden = true
        
        toVC.view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        //toVC.view.alpha = 0.1
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0, options: [.beginFromCurrentState, .curveEaseIn], animations: {
            // TODO
            snapshot?.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
            toVC.view.transform = CGAffineTransform.identity
            blackBackgroundView.alpha = 0
            //toVC.view.alpha = 1
        }) { (success) in
            // TODO
            if success {
                print("complet:success")
            } else {
                print("complet:failed")
            }
            fromVC.view.isHidden = false
            //toVC.view.isHidden = true
            blackBackgroundView.removeFromSuperview()
            snapshot?.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }

}
