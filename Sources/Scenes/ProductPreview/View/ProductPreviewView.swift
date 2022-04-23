//
//  ProductPreviewView.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 21/04/22.
//

import Foundation
import UIKit
import Kingfisher

protocol ProductPreviewViewDelegate: AnyObject {
    func didDismiss()
}

class ProductPreviewView: UIView {

    // MARK: - Subviews

    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        button.setImage(Asset.down.image, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(onTapClose), for: .touchUpInside)
        return button
    }()

    private lazy var productImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .digioBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20.0
        stack.alignment = .center
        stack.distribution = .fill

        [self.titleLabel, self.descriptionLabel].forEach { stack.addArrangedSubview($0) }
        return stack
    }()

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    // MARK: - Private Properties

    private weak var delegate: ProductPreviewViewDelegate?

    internal var productPreview: ProductPreview? {
        didSet {
            productImage.contentMode = productPreview?.isImageSquare ?? true ? .scaleAspectFit : .scaleToFill
            productImage.kf.setImage(
                with: URL(string: productPreview?.image ?? "")
            )
            titleLabel.text = productPreview?.title ?? ""
            descriptionLabel.text = productPreview?.description ?? ""
        }
    }
    // MARK: - Initialization

    init(frame: CGRect, delegate: ProductPreviewViewDelegate?) {
        self.delegate = delegate
        super.init(frame: frame)
        setupViewConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - setup

    func setup(display: ProductPreview) {
        self.productPreview = display
    }

    // MARK: - Action
    
    @objc
    private func onTapClose() {
        delegate?.didDismiss()
    }
}

// MARK: - ViewConfiguration

extension ProductPreviewView: ViewConfiguration {
    func setupConstraints() {

        productImage.anchor(
            top: self.topAnchor,
            left: self.leftAnchor,
            right: self.rightAnchor
        )

        closeButton.anchor(
            top: self.topAnchor,
            left: self.leftAnchor,
            paddingTop: 16,
            paddingLeft: 16,
            width: 40,
            height: 40
        )

        scrollView.anchor(
            top: productImage.bottomAnchor,
            left: self.safeAreaLayoutGuide.leftAnchor,
            bottom: self.safeAreaLayoutGuide.bottomAnchor,
            right: self.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 16,
            paddingLeft: 16,
            paddingRight: 16
        )

        productImage.aspectRation(0.5).isActive = true

        stackView.fillSuperview()

        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }

    func buildViewHierarchy() {

        addSubview(productImage)
        productImage.addSubview(closeButton)
        addSubview(scrollView)
        scrollView.addSubview(stackView)
    }

    func configureViews() {
        backgroundColor = .white
        closeButton.layer.cornerRadius = 20
        closeButton.clipsToBounds = true
    }
}
