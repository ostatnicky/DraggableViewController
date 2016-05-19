//
//  NextViewController.swift
//  DraggableViewController
//
//  Created by Jiri Ostatnicky on 18/05/16.
//  Copyright © 2016 Jiri Ostatnicky. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {
    
    var rootViewController: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.brownColor()
        
        let button = UIButton()
        button.setTitle("Dismiss", forState: .Normal)
        button.addTarget(self, action: #selector(self.buttonTapped), forControlEvents: .TouchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-6-[button]", options: [], metrics: nil, views: ["button": button]))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-20-[button]", options: [], metrics: nil, views: ["button": button]))
    }
    
    func buttonTapped() {
        rootViewController?.disableInteractivePlayerTransitioning = true
        self.dismissViewControllerAnimated(true) { [unowned self] in
            self.rootViewController?.disableInteractivePlayerTransitioning = false
        }
    }
    
}
