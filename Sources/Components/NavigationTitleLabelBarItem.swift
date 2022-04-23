//
//  NavigationTitleLabelBarItem.swift
//  IonAuthenticator
//
//  Created by Mauricio Balena Mazzocco on 07/08/21.
//

import Foundation
import UIKit

/// This class is used to reference title label on Navigation
final class NavigationTitleLabelBarItem: UIBarButtonItem {
    var labelView: TitleViewLabel? {
        customView as? TitleViewLabel
    }
    
    convenience init(label: TitleViewLabel) {
        self.init(customView: label)
    }
}
