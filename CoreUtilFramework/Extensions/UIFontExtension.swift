//
//  UIFontExtension.swift
//  CoreUtilFramework
//
//  Created by Alican Karayelli on 4.07.2018.
//  Copyright © 2018 Alican Karayelli. All rights reserved.
//

import Foundation


public extension UIFont {
    
    /**
     Will return the best font conforming to the descriptor which will fit in the provided bounds.
     */
    static func bestFittingFontSize(for text: String, in bounds: CGRect, fontDescriptor: UIFontDescriptor) -> CGFloat {
        let constrainingDimension = min(bounds.width, bounds.height)
        let properBounds = CGRect(origin: .zero, size: bounds.size)
        
        var bestFontSize: CGFloat = constrainingDimension
        
        for fontSize in stride(from: bestFontSize, through: 0, by: -1) {
            let newFont = UIFont(descriptor: fontDescriptor, size: fontSize)
            let currentFrame = text.boundingRect(with: properBounds.size, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [.font: newFont], context: nil)
            
            if properBounds.contains(currentFrame) {
                bestFontSize = fontSize
                break
            }
        }
        
        return bestFontSize
    }
    
    static func bestFittingFont(for text: String, in bounds: CGRect, fontDescriptor: UIFontDescriptor) -> UIFont {
        let bestSize = bestFittingFontSize(for: text, in: bounds, fontDescriptor: fontDescriptor)
        return UIFont(descriptor: fontDescriptor, size: bestSize)
    }
}


public extension UIFont {

    func sizeOfString (string: String, constrainedToWidth width: Double) -> CGSize {
        return NSString(string: string).boundingRect(
            with: CGSize(width: width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: self],
            context: nil).size
    }

}


public extension UIFont {

    func withTraits(_ traits: UIFontDescriptor.SymbolicTraits) -> UIFont {

        // create a new font descriptor with the given traits
        guard let fd = fontDescriptor.withSymbolicTraits(traits) else {
            // the given traits couldn't be applied, return self
            return self
        }

        // return a new font with the created font descriptor
        return UIFont(descriptor: fd, size: pointSize)
    }

    func italics() -> UIFont {
        return withTraits(.traitItalic)
    }

    func bold() -> UIFont {
        return withTraits(.traitBold)
    }

    func boldItalics() -> UIFont {
        return withTraits([ .traitBold, .traitItalic ])
    }
}
