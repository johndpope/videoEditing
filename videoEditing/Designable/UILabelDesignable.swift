//
//  UILabelDesignable.swift
//  Notes
//
//  Created by Momen Reyad Sisalem on 3/6/20.
//  Copyright © 2020 Momen Reyad Sisalem. All rights reserved.
//

import UIKit

@IBDesignable
class UILabelDesignable: UILabel {
    
    @IBInspectable var bgColor: UIColor = UIColor.orange
    
    @IBInspectable var cornerRadius: CGFloat = 0
    
    @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var borderColor: UIColor = UIColor.black

    @IBInspectable var shadowRadius: CGFloat = 0
    @IBInspectable var shadowBgColor: UIColor = UIColor.gray
    @IBInspectable var shadowOffsetValue: CGSize = CGSize(width: 0, height: 0)
    @IBInspectable var shadowOpacity: Float = 0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.backgroundColor = bgColor.cgColor
        
        layer.cornerRadius = cornerRadius
        
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        
        layer.shadowRadius = shadowRadius
        layer.shadowColor = shadowBgColor.cgColor
        layer.shadowOffset = shadowOffsetValue
        layer.shadowOpacity = shadowOpacity
    }
}
