//
//  ProductPreviewViewController.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 21/04/22.
//

import Foundation
import UIKit

class ProductPreviewViewController: UIViewController {

    // MARK: - Views

    internal lazy var productPreviewView: ProductPreviewView = {
        var view = ProductPreviewView(frame: .zero, delegate: self)
        return view
    }()

    // MARK: - Properties

    typealias ViewModelType = ProductPreviewViewModelProtocol

    var viewModel: ViewModelType!

    // MARK: - Lifecycle

    override func loadView() {
        self.view = productPreviewView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.close()
    }

    // MARK: - Initialization

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        viewModel.preview()
    }
}

// MARK: - bindViewModel

extension ProductPreviewViewController: BindableType {

    func bindViewModel() {
        viewModel.state.bind { [weak self] in
            guard let self = self, let state = $0 else { return }
            switch state {
            case let .initial(productPreview):
                self.productPreviewView.setup(display: productPreview)
            }
        }
    }
}

// MARK: - ProductPreviewViewDelegate

extension ProductPreviewViewController: ProductPreviewViewDelegate {
    func didDismiss() {
        viewModel.close()
    }
}
