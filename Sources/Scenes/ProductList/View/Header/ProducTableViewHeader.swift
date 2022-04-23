//
//  ProducTableViewHeader.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 20/04/22.
//

import Foundation
import UIKit

class ProducTableViewHeader: UITableViewHeaderFooterView {

    private lazy var titleLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .digioBlue
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        
        return label
    }()

    // MARK: - Initialization

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViewConfiguration()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    
    func setup(text: NSAttributedString) {
        titleLabel.attributedText = text
    }
}

// MARK: - ViewConfiguration

extension ProducTableViewHeader: ViewConfiguration {
    func setupConstraints() {
        titleLabel.fillSuperview()
    }

    func buildViewHierarchy() {
        contentView.addSubview(titleLabel)
    }
}
