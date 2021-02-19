//
//  IconTextField.swift
//  Mazad
//
//  Created by Momen Sisalem on 2/4/19.
//  Copyright © 2019 Momen R Sisalem. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable class IconTextField: UITextField {
    
    @IBInspectable var bottomLineColor: UIColor = UIColor.white
    @IBInspectable var placeholderTextColor: UIColor = UIColor.white
    @IBInspectable var icon: UIImage = UIImage()

    override func layoutSubviews() {
        super.layoutSubviews()
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - 1, width: self.frame.width, height: 1.0)
        bottomLine.backgroundColor = bottomLineColor.cgColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
        
        self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: placeholderTextColor])
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.image = icon
//        if L102Language.isRTL{
//            self.rightViewMode = UITextField.ViewMode.always
//            self.rightView = imageView
//        }else{
//            self.leftViewMode = UITextField.ViewMode.always
//            self.leftView = imageView
//        }
    }
}
