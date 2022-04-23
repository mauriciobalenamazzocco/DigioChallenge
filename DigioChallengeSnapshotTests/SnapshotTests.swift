//
//  SnapshotTests.swift
//  DigioChallengeSnapshotTests
//
//  Created by Mauricio Balena Mazzocco on 22/04/22.
//

import UIKit
import FBSnapshotTestCase

open class SnapshotTests: FBSnapshotTestCase {

    // MARK: - Overrides

    open override func setUp() {
        super.setUp()
        resetUserDefaults()
    }

    // MARK: - Public methods

    public func verifySnapshotView(delay: TimeInterval = 0,
                                   tolerance: CGFloat = 0,
                                   identifier: String = "",
                                   file: StaticString = #file,
                                   line: UInt = #line,
                                   framesToRemove: [CGRect] = [],
                                   view: @escaping () -> UIView?) {
        view()?.layoutIfNeeded()
        sleepTest(for: delay)

        guard let view = view() else {
            XCTFail("could not fetch view", file: file, line: line)
            return
        }

        var image = view.asImage()

        if !framesToRemove.isEmpty {
            image = image.addImageWithFrame(frames: framesToRemove) ?? UIImage()
        }

        folderName = customFolderName(file: file)

        let customIdentifier = "\(identifier)_\(UIDevice.current.name.replacingOccurrences(of: " ", with: ""))"

        FBSnapshotVerifyView(UIImageView(image: image),
                             identifier: customIdentifier,
                             suffixes: NSOrderedSet(array: ["_64"]),
                             perPixelTolerance: 0.005,
                             overallTolerance: tolerance,
                             file: file,
                             line: line)
    }

    public func sleepTest(for delay: TimeInterval, file: StaticString = #file, line: UInt = #line) {
        guard delay > 0 else { return }
        let delayExpectation = XCTestExpectation(description: "failed to wait for " + String(delay))
        delayExpectation.assertForOverFulfill = true
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            delayExpectation.fulfill()
        }
        wait(for: [delayExpectation], timeout: 1 + delay)
    }

    // MARK: - Private methods

    private func customFolderName(file: StaticString) -> String {
        let fileName = String(describing: type(of: self))
        let methodName: String = invocation?.selector.description ?? ""
        return "\(fileName)/\(methodName)"
    }

    
    private func resetUserDefaults() {
        let defs = UserDefaults.standard
        let dict = defs.dictionaryRepresentation()

        for (key, _) in dict {
            defs.removeObject(forKey: key)
        }

        defs.synchronize()
    }
}
