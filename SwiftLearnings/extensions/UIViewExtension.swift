//
//  UIViewExtension.swift
//  SwiftLearnings
//
//  Created by user on 03/08/18.
//  Copyright © 2018 this. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    /// To make corner radius of the UIView.
    /// - parameter radiusPoint: CGFloat value of radius.
    func cornerRadius(radiusPoint: CGFloat) {
        self.layer.cornerRadius = radiusPoint
        self.clipsToBounds = true
    }
    /// To make the shadow effect for the UIView.
    /// - parameter color: UIColor value for the UIView.
    func makeShadowEffect(color: UIColor, shadowRadius: CGFloat = 5, shadowOpacity: Float = 0.5) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = shadowRadius
        self.layer.masksToBounds = false
    }
    /// To make the border of the UIView
    /// - parameter borderWidth: CGFloat value for the border width
    /// - parameter borderColor: UIColor Value for the border color
    /// - parameter radiusPoint: CGFloat value for the radius point
    func borderWithCornerRadius(borderWidth: CGFloat, borderColor: UIColor, radiusPoint: CGFloat = 0) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = radiusPoint
        self.clipsToBounds = true
    }
    /// To make the transform animation
    /// - parameter time: It is time duration to complete the animation
    /// - parameter scale: It is the transformation scale
    func animateTransform(time: TimeInterval, scale: CGFloat) {
        UIView.animate(withDuration: time,
                       animations: {
                        self.transform = CGAffineTransform(scaleX: scale, y: scale)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1) {
                self.transform = CGAffineTransform.identity
            }
        })
    }
    /// To make the spring animation
    func springAnimation() {
        UIView.animate(
            withDuration: 2, delay: 0, usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.1, options: [], animations: {
                self.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1) {
                self.transform = CGAffineTransform.identity
            }
        })
    }
}
