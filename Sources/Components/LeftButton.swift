//
//  LeftButton.swift
//  IonAuthenticator
//
//  Created by Mauricio Balena Mazzocco on 07/08/21.
//

import Foundation
import  UIKit

class LeftButton: UIButton {

    // MARK: - Constants
    private let kButtonFrame = CGRect(x: 0, y: 0, width: 40, height: 40)

    // MARK: - Overrides

    override var isHighlighted: Bool {
        didSet {
            animateHighlight()
        }
    }
    
    private func animateHighlight() {
        UIView.animate(withDuration: 0.25, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
            self.alpha = self.isHighlighted ? 0.5 : 1
        })
    }

    // MARK: - Initializers

    init(icon: LeftBarButtomItem, color: UIColor, target: Any?, selector: Selector, round: Bool) {
        super.init(frame: kButtonFrame)

        setup(icon: icon, color: color, target: target, selector: selector, roundButton: round)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setup(icon: LeftBarButtomItem, color: UIColor, target: Any?, selector: Selector, roundButton: Bool) {
        let image = getIconImage(icon: icon)

        if roundButton {
            round()
        }

        addTarget(target, action: selector, for: .touchUpInside)
        setTitleColor(color, for: .normal)
        setImage(image, for: .normal)
        tintColor = color
    }
    private func getIconImage(icon: LeftBarButtomItem) -> UIImage? {
        switch icon {
        case .angleLeft:
            return  Asset.back.image
        case .digioImage:
            return Asset.logo.image?.imageResized(to: CGSize(width: 40, height: 40))
        }
    }
}
extension UIImage {
    func imageResized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
