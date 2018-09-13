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
        self.view.backgroundColor = UIColor.brown
        
        let button = UIButton()
        button.setTitle("Dismiss", for: .normal)
        button.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-6-[button]", options: [], metrics: nil, views: ["button": button]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[button]", options: [], metrics: nil, views: ["button": button]))
    }
    
    @objc func buttonTapped() {
        rootViewController?.disableInteractivePlayerTransitioning = true
        self.dismiss(animated: true) { [unowned self] in
            self.rootViewController?.disableInteractivePlayerTransitioning = false
        }
    }
    
}
