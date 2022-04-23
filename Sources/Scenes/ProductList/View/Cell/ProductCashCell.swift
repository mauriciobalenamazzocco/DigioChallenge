//
//  ProductCashCell.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 20/04/22.
//

import Foundation
import UIKit
import Kingfisher

class ProductCashCell: UITableViewCell {

    // MARK: - Subviews

    private lazy var productImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()

    // MARK: - Private Properties

    private var productPreview: ProductPreview? {
        didSet {
            productImage.kf.setImage(with: URL(string: productPreview?.image ?? ""))
        }
    }

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    func setup(preview: ProductPreview) {
        productPreview = preview
    }

    // MARK: - Life Cycle

    override func prepareForReuse() {
        super.prepareForReuse()
        productImage.image = nil
    }
}

// MARK: - Configuration

extension ProductCashCell: ViewConfiguration {
    func setupConstraints() {
        productImage.fillSuperview()
    }

    func buildViewHierarchy() {
        addSubview(productImage)
    }
    func configureViews() {
        selectionStyle = .none
    }
}
