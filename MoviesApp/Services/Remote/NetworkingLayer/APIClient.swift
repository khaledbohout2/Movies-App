
import Foundation
import Combine

protocol APIClientProtocol {
    func request<T: Decodable>(_ endpoint: APIEndpoint, responseType: T.Type) -> AnyPublisher<T, Error>
}

final class APIClient: APIClientProtocol {
    
    private var bearerToken: String? {
        Bundle.main.object(forInfoDictionaryKey: "API_Read_Access_Token") as? String
    }

    func request<T: Decodable>(_ endpoint: APIEndpoint, responseType: T.Type) -> AnyPublisher<T, Error> {

        var urlComponents = URLComponents(url: endpoint.baseURL.appendingPathComponent(endpoint.path), resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = endpoint.queryParameters
        
        guard let url = urlComponents.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers ?? [:]

        if let token = bearerToken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } else {
            return Fail(error: URLError(.userAuthenticationRequired)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResp = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                if !(200..<300).contains(httpResp.statusCode) {
                    if let apiError = try? JSONDecoder().decode(TMDbError.self, from: data) {
                        throw apiError
                    } else {
                        throw URLError(.badServerResponse)
                    }
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
