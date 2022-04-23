//
//  LeftBarButtonItem.swift
//  IonAuthenticator
//
//  Created by Mauricio Balena Mazzocco on 07/08/21.
//

import Foundation
import UIKit

// MARK: - Public enum

public enum LeftBarButtomItem {
    case angleLeft
    case digioImage
}

class LeftBarButtonItem: UIBarButtonItem {

    // MARK: - Initializers

    init(icon: LeftBarButtomItem, color: UIColor, target: Any?, selector: Selector, round: Bool) {
        super.init()

        setup(icon: icon, color: color, target: target, selector: selector, round: round)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setup(icon: LeftBarButtomItem, color: UIColor, target: Any?, selector: Selector, round: Bool) {
        self.customView = LeftButton(icon: icon, color: color, target: target, selector: selector, round: round)
    }
}
