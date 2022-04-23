//
//  UIVIewController+Extension.swift
//  DigioChallengeSnapshotTests
//
//  Created by Mauricio Balena Mazzocco on 22/04/22.
//

import UIKit

extension UIViewController {
    func loadForSnapshot() {
        viewDidLoad()
        view.frame = UIScreen.main.bounds
        view.layoutIfNeeded()
        viewWillAppear(false)
        viewDidAppear(false)
        beginAppearanceTransition(true, animated: false)
        endAppearanceTransition()
    }
}
