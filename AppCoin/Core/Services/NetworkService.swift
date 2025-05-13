import Foundation

final class NetworkService: Networkable {
    private let baseURL = "https://api.coinpaprika.com/v1"
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetch<T: Decodable>(from endpoint: String) async throws -> T {
        guard let url = URL(string: baseURL + endpoint) else {
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.unknown(NSError(domain: "HTTPResponse", code: 0))
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                do {
                    return try JSONDecoder().decode(T.self, from: data)
                } catch {
                    print("Decoding error: \(error)")
                    throw NetworkError.decodingFailed
                }
            case 401:
                throw NetworkError.unauthorized
            case 500...599:
                throw NetworkError.serverError
            default:
                throw NetworkError.requestFailed(statusCode: httpResponse.statusCode)
            }
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.unknown(error)
        }
    }
}
