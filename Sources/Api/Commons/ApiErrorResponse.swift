import Foundation

/// Example of API Response error
struct ApiErrorResponse: Codable {
    let path: String?
    let timestamp: String?
    let message: String?
    let detailedMessage: String?
}
