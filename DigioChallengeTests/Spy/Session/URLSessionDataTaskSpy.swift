//
//  URLSessionDataTaskSpy.swift
//  DigioChallengeTests
//
//  Created by Mauricio Balena Mazzocco on 22/04/22.
//

import Foundation

class URLSessionDataTaskSpy: URLSessionDataTask {
    var cancelCalled = false
    var resumeCalled = false
    override init () {}

    override func cancel() {
        cancelCalled = true
    }

    override func resume() {
        resumeCalled = true
    }
}
