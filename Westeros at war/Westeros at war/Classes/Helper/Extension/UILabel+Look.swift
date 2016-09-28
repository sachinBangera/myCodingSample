//
//  UILabel+Look.swift
//  Westeros at war
//
//  Created by Sachin on 11/09/16.
//  Copyright © 2016 sachin. All rights reserved.
//

import UIKit

extension UILabel {
    
    func addCharactersSpacing(spacing:CGFloat, text:String) {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSKernAttributeName, value: spacing, range: NSMakeRange(0, text.characters.count))
        self.attributedText = attributedString
    }
    
    func setText(text: String, lineSpacing: CGFloat) {
        let attributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        attributedString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        self.attributedText = attributedString
    }
    
    func requiredHeight() -> CGFloat{
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, self.frame.width, CGFloat.max))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.font = self.font
        label.text = self.text
        label.sizeToFit()
        return label.frame.height
    }
    
    func heightForAttributedString() -> CGFloat{
        let maxSize = CGSizeMake(self.frame.width, CGFloat.max)
        let requiredSize = self.sizeThatFits(maxSize)
        return requiredSize.height
    }
}


extension UITextView {
    
    func setTextToView(heading : String? ,descrpText : String? , lineSpacing: CGFloat) {
        var title =  NSMutableAttributedString(string : "")
        var descript =  NSMutableAttributedString(string : "")
        if let l_heading = heading {
            title =  NSMutableAttributedString(string: "\n" + l_heading + "\n\n")
        }
        
        if let l_descrpText = descrpText {
            descript =  NSMutableAttributedString(string: l_descrpText + "\n")
        }
        
        let attributedString = NSMutableAttributedString(string: (title.string + descript.string))
        attributedString.addAttribute(NSFontAttributeName,
                                      value: UIFont(
                                        name: "Glasgow-Medium",
                                        size: 28.0)!,
                                      range: NSRange(
                                        location:0,
                                        length:title.length))

        
        attributedString.addAttribute(NSFontAttributeName,
                                     value: UIFont(
                                        name: "Glasgow-Light",
                                        size: 16.0)!,
                                     range: NSRange(
                                        location:title.length,
                                        length:descript.length))


        attributedString.addAttribute(NSForegroundColorAttributeName,
                                     value: UIColor.kskFhBlueGreyColor(),
                                     range: NSRange(
                                        location:0,
                                        length:attributedString.length))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        attributedString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(title.length, descript.length))
        self.attributedText = attributedString
    }
    

}
