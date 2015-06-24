//
//  Common.swift
//  test
//
//  Created by Timothy Lee on 10/21/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import Foundation
import UIKit

func CGAffineTransformMakeDegreeRotation(rotation: CGFloat) -> CGAffineTransform {
    return CGAffineTransformMakeRotation(rotation * CGFloat(M_PI / 180))
}

func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}

func convertValue(value: Float, r1Min: Float, r1Max: Float, r2Min: Float, r2Max: Float) -> Float {
    var ratio = (r2Max - r2Min) / (r1Max - r1Min)
    return value * ratio + r2Min - r1Min * ratio
}

func transitionValue(scrollOffset: Float, xOffset: Float, yOffset: Float, scales: Float, rotations: Float, tileView: UIImageView)
    {
    //var offset = Float(scrollView.contentOffset.y)
    
    //x offset: -30 -> 0
    var tx = convertValue(scrollOffset, 0, 568, xOffset, 0)
    //y offset: -285 -> 0
    var ty = convertValue(scrollOffset, 0, 568, yOffset, 0)
    
    var scale = convertValue(scrollOffset, 0, 568, scales, 1)
    
    var rotation = convertValue(scrollOffset, 0, 568, rotations, 0)
    
    //tileOne
    tileView.transform = CGAffineTransformMakeTranslation(CGFloat(tx), CGFloat(ty))
    tileView.transform = CGAffineTransformScale(tileView.transform, CGFloat(scale), CGFloat(scale))
    tileView.transform = CGAffineTransformRotate(tileView.transform, CGFloat(Double(rotation) * M_PI / 180))
}

extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.CGPath
        self.layer.mask = mask
    }
}