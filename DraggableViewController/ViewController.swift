//
//  ViewController.swift
//  DraggableViewController
//
//  Created by Jiri Ostatnicky on 18/05/16.
//  Copyright © 2016 Jiri Ostatnicky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var disableInteractivePlayerTransitioning = false
    
    var bottomBar: BottomBar!
    var nextViewController: NextViewController!
    var presentInteractor: MiniToLargeViewInteractive!
    var dismissInteractor: MiniToLargeViewInteractive!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareView()
    }
    
    func prepareView() {
        bottomBar = BottomBar()
        bottomBar.button.addTarget(self, action: #selector(self.bottomButtonTapped), for: .touchUpInside)
        bottomBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(bottomBar)
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[bottomBar]-0-|", options: [], metrics: nil, views: ["bottomBar": bottomBar]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[bottomBar(\(BottomBar.bottomBarHeight))]-0-|", options: [], metrics: nil, views: ["bottomBar": bottomBar]))
        
        nextViewController = NextViewController()
        nextViewController.rootViewController = self
        nextViewController.transitioningDelegate = self
        nextViewController.modalPresentationStyle = .fullScreen
        
        presentInteractor = MiniToLargeViewInteractive()
        presentInteractor.attachToViewController(viewController: self, withView: bottomBar, presentViewController: nextViewController)
        dismissInteractor = MiniToLargeViewInteractive()
        dismissInteractor.attachToViewController(viewController: nextViewController, withView: nextViewController.view, presentViewController: nil)
    }
    
    @objc func bottomButtonTapped() {
        disableInteractivePlayerTransitioning = true
        self.present(nextViewController, animated: true) { [unowned self] in
            self.disableInteractivePlayerTransitioning = false
        }
    }

}

extension ViewController: UIViewControllerTransitioningDelegate {
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = MiniToLargeViewAnimator()
        animator.initialY = BottomBar.bottomBarHeight
        animator.transitionType = .Present
        return animator
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = MiniToLargeViewAnimator()
        animator.initialY = BottomBar.bottomBarHeight
        animator.transitionType = .Dismiss
        return animator
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard !disableInteractivePlayerTransitioning else { return nil }
        return presentInteractor
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard !disableInteractivePlayerTransitioning else { return nil }
        return dismissInteractor
    }
}

