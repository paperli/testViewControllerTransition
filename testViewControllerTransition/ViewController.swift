//
//  ViewController.swift
//  testViewControllerTransition
//
//  Created by Paper Lee on 09/10/2017.
//  Copyright © 2017 paperworkStudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mTextView: UITextView!
    private let presentAnimationController = PresentAnimationController()
    private let dismissAnimationController = DismissAnimationController()
    private let swipeInteractionController = SwipeInteractionController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let attrbutedText = NSMutableAttributedString(string: self.mTextView.text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 2
        style.lineHeightMultiple = 1.2
        attrbutedText.setAttributes([NSAttributedStringKey.paragraphStyle : style, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16)], range: NSRange(location: 0, length: attrbutedText.length))
        
        //mTextView.layoutManager.delegate = self
        mTextView.attributedText = attrbutedText
        //mTextView.font = UIFont.systemFont(ofSize: 16)
        
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

extension ViewController: NSLayoutManagerDelegate {
    func layoutManager(_ layoutManager: NSLayoutManager, lineSpacingAfterGlyphAt glyphIndex: Int, withProposedLineFragmentRect rect: CGRect) -> CGFloat {
        return 10
    }
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
