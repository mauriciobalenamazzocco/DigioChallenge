//
//  Asset.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 19/04/22.
//

import UIKit

public protocol AssetProtocol {
    var name: String { get }
    var image: UIImage? { get }
}

public enum Asset: String, AssetProtocol {
    case logo
    case down
    case back

    public var name: String {
        return self.rawValue
    }

    public var image: UIImage? {
        return UIImage(named: self.rawValue, in: Bundle.main, compatibleWith: nil)
    }
}
