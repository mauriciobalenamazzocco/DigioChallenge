//
//  UINavigationBar+Extension.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 20/04/22.
//

import Foundation
import UIKit

public extension UINavigationBar {

    @discardableResult
    func setup(_ backgroundColor: UIColor = .white) -> Self {
        isTranslucent = false
        barTintColor = backgroundColor
        barStyle = .black
        return self

    }

}
