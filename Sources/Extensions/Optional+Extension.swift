//
//  Optional+Extension.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 19/04/22.
//

import Foundation
import os.log

extension Optional where Wrapped == Data {
    func parseCodableContent<T: Codable>() -> Either<T> {
        guard let unwrappedSelf = self else {
            return .failure(APIError.serialization(type: T.self))
        }
        
        do {
          
            let object = try JSONDecoder().decode(T.self, from: unwrappedSelf)
            return .success(object)
        } catch let error {
            os_log("%@%@%@", type: .error, "--- SERIALIZATION ERROR\n", error as CVarArg, "\n---")
            return .failure(APIError.serialization(type: T.self))
        }
    }
}
