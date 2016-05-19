//
//  DummyView.swift
//  DraggableViewController
//
//  Created by Jiri Ostatnicky on 18/05/16.
//  Copyright © 2016 Jiri Ostatnicky. All rights reserved.
//

import UIKit

class BottomBar: UIView {
    
    static let bottomBarHeight: CGFloat = 50
    var button: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubview() {
        self.backgroundColor = UIColor.grayColor()
        
        button = UIButton()
        button.setTitle("Tap or drag me", forState: .Normal)
        button.backgroundColor = UIColor.grayColor()
        button.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(button)
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[button]-|", options: [], metrics: nil, views: ["button": button]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[button]-|", options: [], metrics: nil, views: ["button": button]))
    }
}
