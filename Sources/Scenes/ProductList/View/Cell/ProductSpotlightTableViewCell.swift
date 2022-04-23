//
//  ProductSpotlightTableViewCell.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 21/04/22.
//

import Foundation
import UIKit

protocol ProductSpotlightTableViewCellProtocol: AnyObject {
    func didSelectSpotlight(prod: ProductPreview)
}

class ProductSpotlightTableViewCell: UITableViewCell {

    // MARK: - Subviews

    internal lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.frame.size.width, height: 180)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ProductSpotlightCollectionViewCell.self, forCellWithReuseIdentifier: kIdentifier)

        return collectionView
    }()

    // MARK: - Private Properties

    weak var delegate: ProductSpotlightTableViewCellProtocol?
    private let kIdentifier = "ProductSpotlightCollectionViewCelldentifier"

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
          super.prepareForReuse()
    }

    // MARK: - Private Properties

    private var previewDisplay: [ProductPreview] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    // MARK: - Setup

    func setup(preview: [ProductPreview], delegate: ProductSpotlightTableViewCellProtocol?) {
        self.delegate = delegate
        previewDisplay = preview
    }
}

// MARK: - ViewConfiguration

extension ProductSpotlightTableViewCell: ViewConfiguration {
    func setupConstraints() {
        collectionView.fillSuperview()
    }

    func buildViewHierarchy() {
        addSubview(collectionView)
        sendSubviewToBack(contentView)
    }
    func configureViews() {
        selectionStyle = .none
    }
}

// MARK: - UICollectionViewDataSource

extension ProductSpotlightTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return previewDisplay.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: kIdentifier,
            for: indexPath) as? ProductSpotlightCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setup(preview: previewDisplay[indexPath.row])
        return cell
    }

}

// MARK: - UICollectionViewDelegate

extension ProductSpotlightTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let preview = previewDisplay[indexPath.row]
        delegate?.didSelectSpotlight(prod: preview)
    }
}
