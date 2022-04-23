//
//  Enviroment.swift
//  DigioChallenge
//
//  Created by Mauricio Balena Mazzocco on 19/04/22.
//

import Foundation

public enum Enviroment {
    case development
    case homologation
    case production
    case virtual
    var basePath: String {
        switch self {
        case .development:
            return "https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/"

        case .homologation:
             return "https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/"

        case.production:
            return "https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/"

        case .virtual:
            return "https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/"
        }
    }
}
