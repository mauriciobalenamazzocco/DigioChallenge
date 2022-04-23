//
//  ViewConfiguration.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 19/04/22.
//

import Foundation

public protocol ViewConfiguration: AnyObject {
    func setupConstraints()
    func buildViewHierarchy()
    func configureViews()
    func setupViewConfiguration()
}

extension ViewConfiguration {
    public func setupViewConfiguration() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }

    public func configureViews() {
    }
}
