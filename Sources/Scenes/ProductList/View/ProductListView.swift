//
//  ProductListView.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 19/04/22.
//

import Foundation
import UIKit

protocol ProductListViewDelegate: AnyObject {
    func preview(product: ProductPreview)
}

protocol ProductListViewProtocol {
    func setup(display: [ProductSectionDisplay])
    func loading()
}

class ProductListView: UIView {

    // MARK: - Subviews

    internal lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.alwaysBounceVertical = false
        tableView.dataSource = self
        tableView.register(ProducTableViewHeader.self, forHeaderFooterViewReuseIdentifier: kHeaderIdentifier)
        tableView.register(ProductCashCell.self, forCellReuseIdentifier: kCashIdentifier)
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: kProductIdentifier)
        tableView.register(ProductSpotlightTableViewCell.self, forCellReuseIdentifier: kSpotlightIdentifier)
        tableView.separatorStyle = .none
        return tableView
    }()

    private lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .whiteLarge)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.color = .digioBlue
        return view
    }()

    // MARK: - Properties

    weak var delegate: ProductListViewDelegate?

    // MARK: - Private Properties

    private var productSectionDisplay: [ProductSectionDisplay] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - TableView identifiers

    private let kHeaderIdentifier = "ProducTableViewHeaderIdentifier"
    private let kCashIdentifier = "ProductCashCellIdentifier"
    private let kProductIdentifier = "ProductTableViewCellIdentifier"
    private let kSpotlightIdentifier = "ProductSpotlightTableViewCellIdentifier"

    // MARK: - Initialization

    init(frame: CGRect, delegate: ProductListViewDelegate?) {
        self.delegate = delegate
        super.init(frame: frame)
        setupViewConfiguration()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods
extension ProductListView: ProductListViewProtocol {
    func setup(display: [ProductSectionDisplay]) {
        productSectionDisplay = display
        tableView.isHidden = false
        loadingView.isHidden = true
    }

    func loading() {
        tableView.isHidden = true
        loadingView.isHidden = true
        loadingView.startAnimating()
    }
}

// MARK: - ViewConfiguration

extension ProductListView: ViewConfiguration {
    func setupConstraints() {
        loadingView.center(inView: self)
        tableView.anchor(
            top: self.safeAreaLayoutGuide.topAnchor,
            left: self.safeAreaLayoutGuide.leftAnchor,
            bottom: self.safeAreaLayoutGuide.bottomAnchor,
            right: self.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 30,
            paddingLeft: 20,
            paddingBottom: 0,
            paddingRight: 20
        )
    }
    
    func buildViewHierarchy() {
        addSubview(loadingView)
        addSubview(tableView)
    }

    func configureViews() {
        backgroundColor = .white
    }
}

// MARK: - UITableViewDelegate

extension ProductListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.preview(
            product: productSectionDisplay[indexPath.section].content[indexPath.row]
        )
    }
}

// MARK: - UITableViewDataSource

extension ProductListView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        switch ProductListViewSection(indexPath: indexPath) {
        case .spotlight:
            return 180
        case .cash:
            return 130
        case .product:
            return 125
        case .none:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch ProductListViewSection(indexPath: indexPath) {
        case .spotlight:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: kSpotlightIdentifier) as? ProductSpotlightTableViewCell else {
                return UITableViewCell()
            }

            cell.setup(preview: productSectionDisplay[indexPath.section].content, delegate: self)
            return cell
        case .cash:
            guard let cell: ProductCashCell = tableView.dequeueReusableCell(withIdentifier: kCashIdentifier) as? ProductCashCell else {
                return UITableViewCell()
            }
            cell.setup(preview: productSectionDisplay[indexPath.section].content[0])
            return cell
        case .product:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: kProductIdentifier) as? ProductTableViewCell else {
                return UITableViewCell()
            }

            cell.setup(preview: productSectionDisplay[indexPath.section].content, delegate: self)
            return cell
        case .none:
            return UITableViewCell()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return productSectionDisplay.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == ProductListViewSection.spotlight.rawValue {
            return nil
        }

        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: kHeaderIdentifier) as? ProducTableViewHeader
        header?.setup(text: productSectionDisplay[section].title ?? NSAttributedString(string: ""))
        return header
    }
}

// MARK: - ProductSpotlightTableViewCellDelegate

extension ProductListView: ProductSpotlightTableViewCellProtocol {
    func didSelectSpotlight(prod: ProductPreview) {
        delegate?.preview(
            product: prod
        )
    }
}

// MARK: - ProductTableViewCellDelegate

extension ProductListView: ProductTableViewCellProtocol {
    func didSelectProduct(prod: ProductPreview) {
        delegate?.preview(
            product: prod
        )
    }
}
