//
//  RoundedTextField.swift
//  Momma
//
//  Created by Momen Sisalem on 1/2/20.
//  Copyright © 2020 Momen MReyad Sisalem. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class RoundedTextField: UITextField {
    
    @IBInspectable var cornerRadius: CGFloat = 0
    @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var borderColor: UIColor = UIColor.clear
    
    @IBInspectable var bgColor: UIColor = UIColor.white

    @IBInspectable var shadowColor: UIColor = UIColor.gray
    @IBInspectable var shadowOpacity: Float = 2
    @IBInspectable var shadowRadius: CGFloat = 2
    @IBInspectable var shadowOffset: CGSize = CGSize.init(width: 0, height: 0)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.borderStyle = .none
        self.backgroundColor = bgColor

        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = shadowOffset
        self.layer.masksToBounds = false
    }
}

