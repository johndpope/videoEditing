//
//  CustomBorderRoundedUIView.swift
//  Notes
//
//  Created by Momen Sisalem on 1/25/18.
//  Copyright © 2018 Momen Sisalem. All rights reserved.
//

import UIKit

@IBDesignable
class UIViewCustomCornerRadius: UIView {
    
    private var brdColor: UIColor!
    private var brdWidth: CGFloat!
    private var path = UIBezierPath()
    private var maskLayer = CAShapeLayer()
    
    @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var border: Bool = false
    
    //CORNERS
    @IBInspectable var topLeftCorner: CGFloat = 0
    @IBInspectable var bottomLeftCorner: CGFloat = 0
    @IBInspectable var topRightCorner: CGFloat = 0
    @IBInspectable var bottomRightCorner: CGFloat = 0
    
    
    @IBInspectable var flipInRtl: Bool = false
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.borderWidth = borderWidth
        
        self.clipsToBounds = true
        
        setCustomCorners()
    }
    
    private  func setCustomCorners() {
        
        if flipInRtl{
            if L102Language.isRTL{
                let tl = topLeftCorner
                let tr = topRightCorner
                let bl = bottomLeftCorner
                let br = bottomRightCorner
                
                topLeftCorner = tr
                topRightCorner = tl
                bottomLeftCorner = br
                bottomRightCorner = bl
            }
        }
        
        let minx = self.layer.bounds.minX
        let miny = self.layer.bounds.minY
        let maxx = self.layer.bounds.maxX
        let maxy = self.layer.bounds.maxY
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: minx + self.topLeftCorner, y: miny))
        
        path.addLine(to: CGPoint(x: maxx - topRightCorner, y: miny))
        path.addArc(withCenter: CGPoint(x: maxx - topRightCorner, y: miny + topRightCorner), radius: topRightCorner, startAngle:CGFloat(3 * (Double.pi/2)), endAngle: 0, clockwise: true)
        
        path.addLine(to: CGPoint(x: maxx, y: maxy - bottomRightCorner))
        path.addArc(withCenter: CGPoint(x: maxx - bottomRightCorner, y: maxy - bottomRightCorner), radius: bottomRightCorner, startAngle: 0, endAngle: CGFloat((Double.pi/2)), clockwise: true)
        
        path.addLine(to: CGPoint(x: minx + bottomLeftCorner, y: maxy))
        path.addArc(withCenter: CGPoint(x: minx + bottomLeftCorner, y: maxy - bottomLeftCorner), radius: bottomLeftCorner, startAngle: CGFloat((Double.pi/2)), endAngle: CGFloat((Double.pi)), clockwise: true)
        
        path.addLine(to: CGPoint(x: minx, y: miny + topLeftCorner))
        path.addArc(withCenter: CGPoint(x: minx + topLeftCorner, y: miny + topLeftCorner), radius: topLeftCorner, startAngle: CGFloat((Double.pi)), endAngle: CGFloat(3 * (Double.pi/2)), clockwise: true)
        path.close()
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
}
