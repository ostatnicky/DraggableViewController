//
//  BaseAnimator.swift
//  DraggableViewController
//
//  Created by Jiri Ostatnicky on 18/05/16.
//  Copyright © 2016 Jiri Ostatnicky. All rights reserved.
//

import UIKit

enum ModalAnimatedTransitioningType {
    case Present
    case Dismiss
}

class BaseAnimator: NSObject {
    
    var transitionType: ModalAnimatedTransitioningType = .Present
    
    func animatePresentingInContext(transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, toVC: UIViewController) {
        NSException(name:NSExceptionName.internalInconsistencyException, reason:"\(#function) must be overridden in a subclass/category", userInfo:nil).raise()
    }
    
    func animateDismissingInContext(transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, toVC: UIViewController) {
        NSException(name:NSExceptionName.internalInconsistencyException, reason:"\(#function) must be overridden in a subclass/category", userInfo:nil).raise()
    }
    
}

extension BaseAnimator: UIViewControllerAnimatedTransitioning {
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let from = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let to = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        
        if let from = from, let to = to {
            switch transitionType {
            case .Present:
                animatePresentingInContext(transitionContext: transitionContext, fromVC: from, toVC: to)
            case .Dismiss:
                animateDismissingInContext(transitionContext: transitionContext, fromVC: from, toVC: to)
            }
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        NSException(name:NSExceptionName.internalInconsistencyException, reason:"\(#function) must be overridden in a subclass/category", userInfo:nil).raise()
        return 0
    }
}
