//
//  ViewControllerExtension.swift
//  SwiftLearnings
//
//  Created by user on 03/08/18.
//  Copyright © 2018 this. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showToast(message: String) {
        let toastLabel = UILabel(frame: CGRect(x: 10, y: 20, width: self.view.frame.size.width - 20, height: 35))
        toastLabel.backgroundColor = UIColor.white
        toastLabel.textColor = UIColor.black
        toastLabel.textAlignment = .center
        toastLabel.numberOfLines = 0
        toastLabel.cornerRadius(radiusPoint: 5)
        toastLabel.lineBreakMode = .byWordWrapping
        toastLabel.font = UIFont.helvetica(size: 16)
        toastLabel.text = message
        toastLabel.sizeToFit()
        toastLabel.alpha = 1.0
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        let leadingConstraint = NSLayoutConstraint(item: toastLabel, attribute: .leading, relatedBy: .equal,
                                                   toItem: view, attribute: .leading,
                                                   multiplier: 1.0, constant: 10.0)
        let topConstraint = NSLayoutConstraint(item: toastLabel, attribute: .top, relatedBy: .equal,
                                               toItem: view, attribute: .top,
                                               multiplier: 1.0, constant: 5.0)
        let trailingConstraint = NSLayoutConstraint(item: toastLabel, attribute: .trailing, relatedBy: .equal,
                                                    toItem: view, attribute: .trailing,
                                                    multiplier: 1.0, constant: -10.0)
        let heightConstraint = NSLayoutConstraint(item: toastLabel, attribute: .height,
                                                  relatedBy: .greaterThanOrEqual, toItem: nil,
                                                  attribute: .notAnAttribute, multiplier: 1, constant: 35)
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([leadingConstraint, topConstraint, trailingConstraint, heightConstraint])
        UIView.animate(withDuration: 3.0, delay: 2.0, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(_) in
            toastLabel.removeFromSuperview()
        })
    }
}
