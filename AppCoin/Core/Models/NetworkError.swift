import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case requestFailed(statusCode: Int)
    case decodingFailed
    case noData
    case unauthorized
    case serverError
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .requestFailed(let statusCode):
            return "Request failed with status code: \(statusCode)"
        case .decodingFailed:
            return "Failed to decode response"
        case .noData:
            return "No data received"
        case .unauthorized:
            return "Unauthorized"
        case .serverError:
            return "Server error"
        case .unknown(let error):
            return "Unknown error: \(error.localizedDescription)"
        }
    }
}
