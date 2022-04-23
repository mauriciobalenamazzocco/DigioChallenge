//
//  ProductListViewController.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 18/04/22.
//

import UIKit

class ProductListViewController: UIViewController {

    // MARK: - Views

    internal lazy var productListView: ProductListView = {
        var view = ProductListView(frame: .zero, delegate: self)
        return view
    }()

    // MARK: - Properties

    typealias ViewModelType = ProductListViewModelProtocol

    var viewModel: ViewModelType!

    // MARK: - Lifecycle

    override func loadView() {
        self.view = productListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }

    // MARK: - Initialization

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setup() {
        setupNavBar()
        viewModel.getProductList()
    }

    private func setupNavBar() {

        navigationItem
            .withSpace(size: 16)

        navigationItem
            .leftButton(
                .digioImage,
                round: true,
                color: .white,
                target: self,
                selector: #selector(self.navigateToPage)
            ) .withTitle(
                "Olá, Mauricio".setupText(rangeString: "Mauricio", color: .digioBlue),
                frame: self.navigationController?.navigationBar.frame ?? .zero,
                color: .black,
                aligment: .left
            )

        navigationController?.navigationBar.setup()

    }

    @objc internal
    func navigateToPage() {
        viewModel.goToDigioPage()
    }
}

// MARK: - bindViewModel

extension ProductListViewController: BindableType {

    func bindViewModel() {
        viewModel.state.bind { [weak self] in
            guard let self = self, let state = $0 else { return }
            switch state {
            case .loading:
                self.productListView.loading()
            case .error:
               // TODO: Open Error Custom View
                break
            case let .didFetch(response):
                self.productListView.setup(display: response)
            }
        }
    }
}

// MARK: - ProductListViewDelegate

extension ProductListViewController: ProductListViewDelegate {
    func preview(product: ProductPreview) {
        viewModel.toPreview(product: product)
    }
}
