//
//  RoundedShadowButton.swift
//  ButtonExtension
//
//  Created by Sidram K on 12/07/20.
//  Copyright © 2020 Sidram K. All rights reserved.
//

import UIKit

class RoundedShadowButton: UIButton {
    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = 5.0
    }
    
    func animateButton(_ animated: Bool) {
        
        if animated {
            UIView.animate(withDuration: 0.25, animations: {
                self.layer.cornerRadius = self.frame.height / 2
                self.frame = CGRect(x: self.frame.midX - (self.frame.height / 2) , y: self.frame.origin.y, width: self.frame.height, height: self.frame.height)
                self.clipsToBounds = true
            }, completion: { (_) in
                self.layer.cornerRadius = self.frame.height / 2
                             self.frame = CGRect(x: self.frame.midX - (self.frame.height / 2) , y: self.frame.origin.y, width: self.frame.height, height: self.frame.height)
            })
        }
    }
    
}
