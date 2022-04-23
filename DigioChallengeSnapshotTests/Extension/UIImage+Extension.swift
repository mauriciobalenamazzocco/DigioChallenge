//
//  UIImage+Extension.swift
//  DigioChallengeSnapshotTests
//
//  Created by Mauricio Balena Mazzocco on 22/04/22.
//

import UIKit
import XCTest

public extension UIImage {

    func addImageWithFrame(frames: [CGRect]) -> UIImage? {
        let imageSize = size
        let scale: CGFloat = 0
        UIGraphicsBeginImageContextWithOptions(imageSize, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        draw(at: .zero)
        context.setFillColor(UIColor.black.cgColor)
        context.addRects(frames)
        context.drawPath(using: .fill)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
