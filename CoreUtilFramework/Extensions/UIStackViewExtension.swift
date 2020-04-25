//  UIStackViewExtension.swift
//  CoreUtilFramework 
//
//  User: Alican.Karayelli
//  Date: 26.04.2020
//  Time: 01:21

import Foundation

public extension UIStackView {
    
    func customize(backgroundColor: UIColor = .clear, radiusSize: CGFloat = 0) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = backgroundColor
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)

        subView.layer.cornerRadius = radiusSize
        subView.layer.masksToBounds = true
        subView.addShadow(radius: 8, offset: CGSize(width: 0, height: 1), opacity: 0.2)
        subView.clipsToBounds = true
    }
}
