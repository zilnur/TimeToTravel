//
//  UIViewExtension.swift
//  Time to travel
//
//  Created by Ильнур Закиров on 14.05.2023.
//

import Foundation
import UIKit

extension UIView {
    
    func toLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //Мини framework для Autolayout
    func anchor(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
            
            if let top = top {
                topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
            }
            
            if let leading = leading {
                leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
            }
            
            if let bottom = bottom {
                bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
            }
            
            if let trailing = trailing {
                trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
            }
            
            if size.width != 0 {
                widthAnchor.constraint(equalToConstant: size.width).isActive = true
            }
            
            if size.height != 0 {
                heightAnchor.constraint(equalToConstant: size.height).isActive = true
            }
    }
}
