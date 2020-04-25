

import Foundation
import UIKit

public extension UILabel{

    @IBInspectable var adjustable:Bool {
        set {
            if(newValue){
                self.numberOfLines = 0
                self.adjustsFontSizeToFitWidth = true
                self.minimumScaleFactor = 9.0 / UIFont.labelFontSize
                self.lineBreakMode = .byTruncatingTail
            }
        }
        
        get {
            return (self.numberOfLines == 0 && (self.adjustsFontSizeToFitWidth) && self.lineBreakMode == .byTruncatingTail)
        }
    }
    

    /**
     Resize the font to make the current text fit the label frame.
     
     - parameter maxFontSize:  The max font size available
     - parameter minFontScale: The min font scale that the font will have
     - parameter rectSize:     Rect size where the label must fit
     */
    func fontSizeToFit(maxFontSize: CGFloat = 100, minFontScale: CGFloat = 0.1, rectSize: CGSize? = nil) {
        guard let unwrappedText = self.text else {
            return
        }
        
        let newFontSize = fontSizeThatFits(text: unwrappedText, maxFontSize: maxFontSize, minFontScale: minFontScale, rectSize: rectSize)
        font = font.withSize(newFontSize)
    }
    
    /**
     Returns a font size of a specific string in a specific font that fits a specific size
     
     - parameter text:         The text to use
     - parameter maxFontSize:  The max font size available
     - parameter minFontScale: The min font scale that the font will have
     - parameter rectSize:     Rect size where the label must fit
     */
    func fontSizeThatFits(text string: String, maxFontSize: CGFloat = 100, minFontScale: CGFloat = 0.1, rectSize: CGSize? = nil) -> CGFloat {
        let maxFontSize = maxFontSize.isNaN ? 100 : maxFontSize
        let minFontScale = minFontScale.isNaN ? 0.1 : minFontScale
        let minimumFontSize = maxFontSize * minFontScale
        let rectSize = rectSize ?? bounds.size
        guard string.count != 0 else {
            return self.font.pointSize
        }
        
        
        let constraintSize = numberOfLines == 1 ?
            CGSize(width: CGFloat.greatestFiniteMagnitude, height: rectSize.height) :
            CGSize(width: rectSize.width, height: CGFloat.greatestFiniteMagnitude)
        return binarySearch(string: string, minSize: minimumFontSize, maxSize: maxFontSize, size: rectSize, constraintSize: constraintSize)
    }
    
    
    /// Will auto resize the contained text to a font size which fits the frames bounds.
    /// Uses the pre-set font to dynamically determine the proper sizing
    func fitTextToBounds() {
        guard let text = text, let currentFont = font else { return }
        
        let bestFittingFont = UIFont.bestFittingFont(for: text, in: bounds, fontDescriptor: currentFont.fontDescriptor)
        font = bestFittingFont
    }
    
}

// MARK: - Helpers

private extension UILabel {
    
    func currentAttributedStringAttributes() -> [NSAttributedString.Key : Any] {
        var newAttributes = [NSAttributedString.Key: Any]()
        attributedText?.enumerateAttributes(in: NSRange(0..<(text?.count ?? 0)), options: .longestEffectiveRangeNotRequired, using: { attributes, range, stop in
            newAttributes = attributes
        })
        return newAttributes
    }
    
}

// MARK: - Search

private extension UILabel {
    
    enum FontSizeState {
        case Fit, TooBig, TooSmall
    }
    
    func binarySearch(string: String, minSize: CGFloat, maxSize: CGFloat, size: CGSize, constraintSize: CGSize) -> CGFloat {
        let fontSize = (minSize + maxSize) / 2
        var attributes = currentAttributedStringAttributes()
        attributes[NSAttributedString.Key.font] = font.withSize(fontSize)
        
        let rect = string.boundingRect(with: constraintSize, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        let state = numberOfLines == 1 ? singleLineSizeState(rect: rect, size: size) : multiLineSizeState(rect: rect, size: size)
        
        // if the search range is smaller than 0.1 of a font size we stop
        // returning either side of min or max depending on the state
        let diff = maxSize - minSize
        guard diff > 0.1 else {
            switch state {
            case .TooSmall:
                return maxSize
            default:
                return minSize
            }
        }
        
        switch state {
        case .Fit: return fontSize
        case .TooBig: return binarySearch(string: string, minSize: minSize, maxSize: fontSize, size: size, constraintSize: constraintSize)
        case .TooSmall: return binarySearch(string: string, minSize: fontSize, maxSize: maxSize, size: size, constraintSize: constraintSize)
        }
    }
    
    func singleLineSizeState(rect: CGRect, size: CGSize) -> FontSizeState {
        if rect.width >= size.width + 10 && rect.width <= size.width {
            return .Fit
        } else if rect.width > size.width {
            return .TooBig
        } else {
            return .TooSmall
        }
    }
    
    func multiLineSizeState(rect: CGRect, size: CGSize) -> FontSizeState {
        // if rect within 10 of size
        if rect.height < size.height + 10 &&
            rect.height > size.height - 10 &&
            rect.width > size.width + 10 &&
            rect.width < size.width - 10 {
            return .Fit
        } else if rect.height > size.height || rect.width > size.width {
            return .TooBig
        } else {
            return .TooSmall
        }
    }

    
}
