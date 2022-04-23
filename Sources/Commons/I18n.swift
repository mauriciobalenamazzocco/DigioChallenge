//
//  I18n.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 19/04/22.
//

import Foundation

protocol I18nProtocol {
    var text: String { get }

    func text(with complement: String...) -> String
}

class I18n {
    // MARK: - General

    enum General: String, I18nProtocol {
        case ok
        case back
        case cancel
        case digioCashTitle
        case productTitle
        case errorTitle

        var text: String {
            return NSLocalizedString(self.rawValue, comment: "")
        }

        func text(with complement: String...) -> String {
            return String(
                format: NSLocalizedString(self.rawValue, comment: "%@"),
                arguments: complement
            )
        }
    }

    // MARK: - APIError

    enum APIError: String, I18nProtocol {
        case serialization
        case badRequest
        case forbidden
        case notFound
        case serverError
        case unauthorized

        var text: String {
            return NSLocalizedString(self.rawValue, comment: "")
        }

        func text(with complement: String...) -> String {
            return String(
                format: NSLocalizedString(self.rawValue, comment: "%@"),
                arguments: complement
            )
        }
    }
}
