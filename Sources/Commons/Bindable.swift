//
//  Bindable.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 19/04/22.
//

public class Bindable<T> {

    // MARK: - Typealias

    public typealias BindType = ((T) -> Void)

    // MARK: - Properties

    public var binds: [BindType] = []

    /// Dynamic raw value
    public var value: T {
        didSet {
            execBinds()
        }
    }

    // MARK: - Initializer

    /// Initializer
    /// - Parameter val: initial dynamic value
    public init(_ val: T) {
        value = val
    }

    // MARK: - Public Methods

    /// Binding value for changes
    /// - Parameters:
    ///   - skip: boolean to decide if it should ignore ending callback from init
    ///   - bind: callback to notify changed value
    public func bind(skip: Bool = false, _ bind: @escaping BindType) {
        binds.append(bind)
        guard skip else {
            bind(value)
            return
        }
    }

    public func remove() {
        _ = binds.popLast()
    }

    // MARK: - Private Methods

    /// Execute bindings
    private func execBinds() {
        binds.forEach { [unowned self] bind in
            bind(self.value)
        }
    }
}
