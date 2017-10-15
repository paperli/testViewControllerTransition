//
//  DetailViewController.swift
//  testViewControllerTransition
//
//  Created by Paper Lee on 09/10/2017.
//  Copyright © 2017 paperworkStudio. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    private let presentAnimationController = PresentAnimationController()
    private let dismissAnimationController = DismissAnimationController()
    private let swipeInteractionController = SwipeInteractionController()
    
    @IBOutlet weak var tableView: UITableView!
    //private var lastContentOffsetY: CGFloat = 0
    //private var scrollingUp = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("DetailViewController::viewDidLoad")
        self.transitioningDelegate = self
        swipeInteractionController.wireToViewController(viewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
 
    
    @IBAction func dismissVC(_ sender: Any) {
        dismiss(animated: true) {
            // TODO
        }
    }
    
    @IBAction func unwindToVC(segue:UIStoryboardSegue) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("DetailViewController::viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("DetailViewController::viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("DetailViewController::viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("DetailViewController::viewDidDisappear")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("DetailViewController::viewDidLayoutSubviews")
    }
    
}

/*extension DetailViewController: UIViewControllerTransitioningDelegate {
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return swipeInteractionController.interactionInProgress ? swipeInteractionController : nil
    }
}*/

extension DetailViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.bounces = scrollView.contentOffset.y > 10
        
        //self.scrollingUp = self.lastContentOffsetY >= scrollView.contentOffset.y
        //print("scrolling up: \(self.scrollingUp):::last:\(self.lastContentOffsetY):::new:\(scrollView.contentOffset.y)")
        //sself.lastContentOffsetY = scrollView.contentOffset.y
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell")
        cell?.textLabel?.text = "cell \(String(indexPath.row))"
        return cell!
    }
    
}

extension DetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        let translation = tableView.panGestureRecognizer.translation(in: tableView)
        let offset = tableView.contentOffset
        print(translation.y)
        //print("current:\(offset.y):::::last:\(self.lastContentOffsetY)")
        if offset.y <= 0 && translation.y > 0 {
            return true
        } else {
            return false
        }
    }
}

extension DetailViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentAnimationController
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissAnimationController
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return swipeInteractionController.interactionInProgress ? swipeInteractionController : nil
    }
}
