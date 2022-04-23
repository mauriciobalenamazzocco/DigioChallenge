//
//  String+Extension.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 20/04/22.
//

import Foundation
import UIKit

extension String {
    func setupText(rangeString: String, color: UIColor, fontSize: CGFloat = 16) -> NSAttributedString {
        let range = (self as NSString).range(of: rangeString)
        let mutableAttributedString = NSMutableAttributedString(string: self)
        mutableAttributedString.addAttribute(
            NSAttributedString.Key.foregroundColor,
            value: color, range: range
        )
         mutableAttributedString.addAttribute(
             NSAttributedString.Key.font,
             value: UIFont.boldSystemFont(ofSize: fontSize), range: range
         )

        return mutableAttributedString
    }
}
