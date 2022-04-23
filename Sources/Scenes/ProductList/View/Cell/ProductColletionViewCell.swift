//
//  ProductColletionViewCell.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 20/04/22.
//

import Foundation
import UIKit
import Kingfisher

class ProductColletionViewCell: UICollectionViewCell {

    // MARK: - Subviews

    private lazy var containerView: ShadowView = {
        let view = ShadowView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    private lazy var productImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func prepareForReuse() {
        super.prepareForReuse()
        productImage.image = nil
    }

    // MARK: - Setup

    func setup(preview: ProductPreview) {
         productImage.kf.setImage(with: URL(string: preview.image))
    }

}
// MARK: - ViewConfiguration

extension ProductColletionViewCell: ViewConfiguration {
    func setupConstraints() {
        backgroundColor = .clear
        containerView.anchor(
            top: self.topAnchor,
            left: self.leftAnchor,
            bottom: self.bottomAnchor,
            right: self.rightAnchor,
            paddingTop: 5,
            paddingLeft: 5,
            paddingBottom: 5,
            paddingRight: 5
        )
        
        productImage.center(inView: containerView)
        productImage.setDimensions(
            height: 60,
            width: 60
        )
    }

    func buildViewHierarchy() {
        addSubview(containerView)
        containerView.addSubview(productImage)
    }
}
