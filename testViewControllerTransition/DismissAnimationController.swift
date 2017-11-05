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
        
        var blackBackgroundView: UIView
        
        if let tempView = toVC.view.viewWithTag(3) {
            // already have the black overlay view
            //print("oh yeah there is the view")
            blackBackgroundView = tempView
        } else {
            //print("no view")
            blackBackgroundView = UIView()
            blackBackgroundView.tag = 3
            blackBackgroundView.frame = toVC.view.bounds
            blackBackgroundView.backgroundColor = UIColor.black
            blackBackgroundView.alpha = 0
            blackBackgroundView.isUserInteractionEnabled = false
            toVC.view.addSubview(blackBackgroundView)
        }
        
        let containerView = transitionContext.containerView
        
        //let initialFrame = transitionContext.initialFrame(for: fromVC)
        
        let snapshot = fromVC.view.snapshotView(afterScreenUpdates: false)
        snapshot?.transform = fromVC.view.transform
        
        //containerView.addSubview(toVC.view)
        containerView.addSubview(snapshot!)
        fromVC.view.isHidden = true
        
        toVC.view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        //toVC.view.alpha = 0.1
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: [.beginFromCurrentState], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3, animations: {
                blackBackgroundView.alpha = 0
            })
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0, animations: {
                snapshot?.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
                toVC.view.transform = CGAffineTransform.identity
            })
        }) { (success) in
            if success {
                print("complete:success")
            } else {
                print("complete:failed")
            }
            fromVC.view.isHidden = false
            snapshot?.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        /*UIView.animate(withDuration: duration, delay: 0, options: [.beginFromCurrentState, .curveEaseIn], animations: {
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
            //blackBackgroundView.removeFromSuperview()
            snapshot?.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }*/
        
    }

}
