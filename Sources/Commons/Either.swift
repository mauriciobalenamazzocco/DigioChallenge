//
//  ConfirmeViewController.swift
//  SDKAuthn
//
//  Created by Mauricio Balena Mazzocco on 22/04/21.
//

import Foundation

public enum Either<T> {
    case success(T)
    case failure(APIError)
}

public func ==<T: Equatable>(lhs: Either<T>, rhs: Either<T>) -> Bool {
    switch (lhs, rhs) {
    case (.failure(let leftError), .failure(let rightError)):
        return leftError == rightError

    case (.success(let leftValue), .success(let rightValue)):
        return leftValue == rightValue

    default:
        return false
    }
}

public func == (lhs: Either<Void>, rhs: Either<Void>) -> Bool {
    switch (lhs, rhs) {
    case (.failure(let leftError), .failure(let rightError)):
        return leftError == rightError

    case (.success, .success):
        return true

    default:
        return false
    }
}

public extension Either {
    func map<U>(_ transform: (T) -> U) -> Either<U> {
        switch self {
        case .failure(let apiError):
            return .failure(apiError)
        case .success(let value):
            return .success(transform(value))
        }
    }

    func flatMap<U>(_ transform: (T) -> Either<U>) -> Either<U> {
        switch self {
        case .failure(let error):
            return .failure(error)
        case .success(let value):
            return transform(value)
        }
    }
}
