//
//  PresentAnimationController.swift
//  testViewControllerTransition
//
//  Created by Paper Lee on 09/10/2017.
//  Copyright © 2017 paperworkStudio. All rights reserved.
//

import UIKit

class PresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    //var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // TODO
        let containerView = transitionContext.containerView
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from), let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
            return
        }
        
        //let initialFrame = originFrame
        let finalFrame = transitionContext.finalFrame(for: toVC)
        
        let snapshot = toVC.view.snapshotView(afterScreenUpdates: true)
        snapshot?.frame = finalFrame
        
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshot!)
        toVC.view.isHidden = true
        
        snapshot?.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
        
        let blackBackgroundView = UIView()
        blackBackgroundView.frame = fromVC.view.bounds
        blackBackgroundView.backgroundColor = UIColor.black
        blackBackgroundView.alpha = 0
        fromVC.view.addSubview(blackBackgroundView)
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [.beginFromCurrentState], animations: {
            // TODO
            fromVC.view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            snapshot?.transform = CGAffineTransform.identity
            blackBackgroundView.alpha = 0.5
            
        }) { (success) in
            // TODO
            toVC.view.isHidden = false
            fromVC.view.transform = CGAffineTransform.identity
            snapshot?.removeFromSuperview()
            blackBackgroundView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    

}
