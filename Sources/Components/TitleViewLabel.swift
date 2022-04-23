//
//  TitleViewLabel.swift
//  IonAuthenticator
//
//  Created by Mauricio Balena Mazzocco on 07/08/21.
//

import Foundation
import UIKit

public final class TitleViewLabel: UILabel {
    
    // MARK: - Private properties
    
    private let titleLabelAccessibilityId = "titleLabel"
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        accessibilityIdentifier = titleLabelAccessibilityId
        accessibilityTraits = .header
        lineBreakMode = .byTruncatingTail
        font = .systemFont(ofSize: 16)
        numberOfLines = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
