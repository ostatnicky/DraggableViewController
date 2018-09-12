//
//  MiniToLargeViewAnimator.swift
//  DraggableViewController
//
//  Created by Jiri Ostatnicky on 18/05/16.
//  Copyright © 2016 Jiri Ostatnicky. All rights reserved.
//

import UIKit

class MiniToLargeViewAnimator: BaseAnimator {
    
    var initialY: CGFloat = 0
    
    override func animatePresentingInContext(transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, toVC: UIViewController) {
        
        let fromRect = transitionContext.initialFrame(for: fromVC)
        var toRect = fromRect
        toRect.origin.y = toRect.size.height - initialY
        
        toVC.view.frame = toRect
        let container = transitionContext.containerView
        let imageView = fakeMiniView()
        
        toVC.view.addSubview(imageView)
        container.addSubview(fromVC.view)
        container.addSubview(toVC.view)
        
        let animOptions: UIViewAnimationOptions = transitionContext.isInteractive ? [UIViewAnimationOptions.curveLinear] : []
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: animOptions, animations: {
            toVC.view.frame = fromRect
            imageView.alpha = 0
        }) { (finished) in
            imageView.removeFromSuperview()
            if transitionContext.transitionWasCancelled {
                transitionContext.completeTransition(false)
            } else {
                transitionContext.completeTransition(true)
            }
        }
    }
    
    override func animateDismissingInContext(transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, toVC: UIViewController) {
        
        var fromRect = transitionContext.initialFrame(for: fromVC)
        fromRect.origin.y = fromRect.size.height - initialY
        
        let imageView = fakeMiniView()
        imageView.alpha = 0
        fromVC.view.addSubview(imageView)
        
        let container = transitionContext.containerView
        container.addSubview(toVC.view)
        container.addSubview(fromVC.view)
        
        let animOptions: UIViewAnimationOptions = transitionContext.isInteractive ? [UIViewAnimationOptions.curveLinear] : []
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: animOptions, animations: {
            fromVC.view.frame = fromRect
            imageView.alpha = 1
        }) { (finished) in
            imageView.removeFromSuperview()
            if transitionContext.transitionWasCancelled {
                transitionContext.completeTransition(false)
            } else {
                transitionContext.completeTransition(true)
            }
        }
    }
    
    override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionContext!.isInteractive ? 0.4 : 0.3
    }
    
    func fakeMiniView() -> UIView {
        // Fake a mini view, two ways:
        // 1. create a new certain one
        // 2. snapshot old one.
        
        return BottomBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: BottomBar.bottomBarHeight))
    }
    
}
