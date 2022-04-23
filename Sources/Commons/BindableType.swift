//
//  BindableType.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 19/04/22.
//

import UIKit

protocol BindableType {
    associatedtype ViewModelType

    var viewModel: ViewModelType! { get set }
    func bindViewModel()
}

// MARK: - UIViewController
extension BindableType where Self: UIViewController {
    mutating func bind(to model: Self.ViewModelType) {
        self.viewModel = model
        loadViewIfNeeded()
        bindViewModel()
    }
}
