//
//  CrossButton.swift
//  CustomParts
//
//  Created by hf on 2016/11/20.
//  Copyright © 2016年 swift-studying.com. All rights reserved.
//

import UIKit

@IBDesignable
public class CrossButton: UIButton {
    @IBInspectable var borderWidth:CGFloat = 2.0
    @IBInspectable var defaultBorderColor:UIColor = .black
    @IBInspectable var highlighteBorderColor:UIColor = .black
    @IBInspectable var defaultCircleBackgroundColor:UIColor = .white
    @IBInspectable var highlightedCircleBackgroundColor:UIColor = .lightGray
    @IBInspectable var crossLineWidth:CGFloat = 2.0
    @IBInspectable var defaultCrossLineColor:UIColor = .black
    @IBInspectable var highlitedCrossLineColor:UIColor = .black
    @IBInspectable var crossLineDiameter:CGFloat = 16.0{
        didSet{
            let hypotenuse = hypot(crossLineDiameter, crossLineDiameter)
            if bounds.size.width < hypotenuse + borderWidth * 2{
                fatalError("hypotenuse is over in circle")
            }
        }
    }
    
    public override func draw(_ rect: CGRect) {
        let innerCicleSize = CGSize(
                                width: rect.size.width - borderWidth * 2.0,
                                height: rect.size.height - borderWidth * 2.0)
        let padding = ((innerCicleSize.width - crossLineDiameter) / 2) + borderWidth
        func drawCrossButton(isHighlited:Bool){
            let circle = UIBezierPath(
                ovalIn: CGRect(
                    origin: CGPoint(x:borderWidth, y:borderWidth),
                    size: innerCicleSize))
            (isHighlited ? highlightedCircleBackgroundColor : defaultCircleBackgroundColor).setFill()
            circle.fill()
            (isHighlited ? highlighteBorderColor : defaultBorderColor).setStroke()
            circle.lineWidth = borderWidth
            circle.stroke()
            
            let lineColor = (isHighlited ? highlitedCrossLineColor : defaultCrossLineColor)
            let leftLine = UIBezierPath()
            leftLine.move(to: CGPoint(x: padding, y: padding))
            leftLine.addLine(to: CGPoint(x: rect.size.width - padding, y: rect.size.height - padding))
            leftLine.close()
            lineColor.setStroke()
            leftLine.lineWidth = crossLineWidth
            leftLine.stroke()
            
            let rightLine = UIBezierPath()
            rightLine.move(to: CGPoint(x: rect.size.width - padding, y: padding))
            rightLine.addLine(to: CGPoint(x: padding, y: rect.size.height - padding))
            rightLine.close()
            lineColor.setStroke()
            rightLine.lineWidth = crossLineWidth
            rightLine.stroke()
        }
        
        // draw cross button
        drawCrossButton(isHighlited: isHighlighted)
    }
    
    public override var isHighlighted: Bool{
        didSet{
            setNeedsDisplay()
        }
    }
}
