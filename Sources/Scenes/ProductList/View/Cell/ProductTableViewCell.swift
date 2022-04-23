//
//  ProductTableViewCell.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 20/04/22.
//

import Foundation
import UIKit

protocol ProductTableViewCellProtocol: AnyObject {
    func didSelectProduct(prod: ProductPreview)
}

class ProductTableViewCell: UITableViewCell {

    // MARK: - Subviews

    internal lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 125, height: 125)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ProductColletionViewCell.self, forCellWithReuseIdentifier: kIdentifier)

        return collectionView
    }()

    // MARK: - Private Properties

    weak var delegate: ProductTableViewCellProtocol?
    private let kIdentifier = "ProductColletionViewCellIdentifier"

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Properties

    private var previewDisplay: [ProductPreview] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    // MARK: - Setup

    func setup(preview: [ProductPreview], delegate: ProductTableViewCellProtocol?) {
        self.delegate = delegate
        previewDisplay = preview

    }
}

// MARK: - ViewConfiguration

extension ProductTableViewCell: ViewConfiguration {
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

extension ProductTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return previewDisplay.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kIdentifier, for: indexPath) as? ProductColletionViewCell else {
            return UICollectionViewCell()
        }
        cell.setup(preview: previewDisplay[indexPath.row])
        return cell
    }

}

// MARK: - UICollectionViewDelegate

extension ProductTableViewCell: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectProduct(
            prod: previewDisplay[indexPath.row]
        )
    }

}
