//
//  UINavigationIten+Extension.swift
//  IonAuthenticator
//
//  Created by Mauricio Balena Mazzocco on 07/08/21.
//

import Foundation
import UIKit

extension UINavigationItem {
    
    // MARK: - Public methods
    
    @discardableResult
    func leftButton(
        _ icon: LeftBarButtomItem = .angleLeft,
        round: Bool = false,
        color: UIColor,
        target: Any?,
        selector: Selector
    ) -> Self {

        let leftButton = LeftBarButtonItem(icon: icon, color: color, target: target, selector: selector, round: round)
        appendLeftButtomItem(leftButton)
        
        return self
    }

    func withSpace(size: CGFloat) {
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: nil, action: nil)
        space.width = size
        appendLeftButtomItem(space)
    }
    
    func withTitle(
        _ text: NSAttributedString,
        frame: CGRect,
        color: UIColor,
        aligment: NSTextAlignment = .center) {
        
        let label = TitleViewLabel(frame: frame)
        
        label.textAlignment = aligment
        label.textColor = color
        label.font = .systemFont(ofSize: 16)
        label.attributedText = text
        titleView = UIView()
        
        let leftItem = NavigationTitleLabelBarItem(label: label)
        
        appendLeftButtomItem(leftItem)
    }
    
    // MARK: - Private methods
    
    private func appendLeftButtomItem(_ button: UIBarButtonItem) {
        if let barButtonItems = leftBarButtonItems {
            
            let buttons = barButtonItems + [button]
            
            leftBarButtonItems = buttons
            
        } else {
            leftBarButtonItems = [button]
        }
    }
}

extension UINavigationController {

   open override var preferredStatusBarStyle: UIStatusBarStyle {
      return topViewController?.preferredStatusBarStyle ?? .default
   }
}
