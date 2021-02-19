//
//  UIViewDesignable.swift
//  Notes
//
//  Created by Momen Reyad Sisalem on 3/6/20.
//  Copyright © 2020 Momen Reyad Sisalem. All rights reserved.
//

import UIKit

@IBDesignable
class UIViewDesignable: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0
    @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var borderColor: UIColor = UIColor.black
    @IBInspectable var shadowRadius: CGFloat = 0
    @IBInspectable var shadowColor: UIColor = UIColor.gray
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 0)
    @IBInspectable var shadowOpacity: Float = 0
  
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.shadowRadius = shadowRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
    }
    
    public func animateOfView(){
      
        let someView = UIView()
        let scaleTransform = CGAffineTransform(scaleX:1.2, y: 1.2)
        someView.transform = scaleTransform

        UIView.animate(withDuration: 0.50, delay: 0, options: .curveEaseIn, animations: {
            someView.transform = CGAffineTransform.identity
        })
    }
    
    
}
