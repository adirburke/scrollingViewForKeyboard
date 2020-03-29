//
//  File.swift
//  testingNewLayout
//
//  Created by home on 5/7/18.
//  Copyright © 2018 home. All rights reserved.
//

import UIKit

public extension UIView {
    
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        _ = anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor, padding: padding)
    }
    
    func fillSpecificView(view : UIView, padding: UIEdgeInsets = .zero) {
        _ = anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: padding)
    }

    func anchorSize(to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero, isActive : Bool = true) -> (NSLayoutConstraint?, NSLayoutConstraint?, NSLayoutConstraint?, NSLayoutConstraint?, NSLayoutConstraint?, NSLayoutConstraint?){
        translatesAutoresizingMaskIntoConstraints = false
        
        var topCon : NSLayoutConstraint?
        var botCon : NSLayoutConstraint?
        var trailingCon : NSLayoutConstraint?
        var leadingCon : NSLayoutConstraint?
        var heightCon : NSLayoutConstraint?
        var widthCon : NSLayoutConstraint?
        
        if let top = top {
           topCon = topAnchor.constraint(equalTo: top, constant: padding.top)
                topCon?.isActive = isActive
        }
        
        if let leading = leading {
            leadingCon = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
                leadingCon?.isActive = isActive
        }
        
        if let bottom = bottom {
            botCon = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
            botCon?.isActive = isActive
        }
        
        if let trailing = trailing {
            trailingCon = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
            trailingCon?.isActive = isActive
            
        }
        
        if size.width != 0 {
            widthCon = widthAnchor.constraint(equalToConstant: size.width)
                widthCon?.isActive = isActive
        }
        
        if size.height != 0 {
            heightCon = heightAnchor.constraint(equalToConstant: size.height)
                heightCon?.isActive = isActive
        }
        return (topCon, leadingCon, botCon, trailingCon, heightCon, widthCon)
        
    }
}
