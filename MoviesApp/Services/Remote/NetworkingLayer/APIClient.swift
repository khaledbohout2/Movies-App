
import Foundation
import Combine

protocol APIClientProtocol {
    func request<T: Decodable>(_ endpoint: APIEndpoint, responseType: T.Type) -> AnyPublisher<T, APIError>
}

final class APIClient: APIClientProtocol {

    private let decoder: ResponseDecoder

    init(decoder: ResponseDecoder) {
        self.decoder = decoder
    }

    private var bearerToken: String? {
        Bundle.main.object(forInfoDictionaryKey: "API_Read_Access_Token") as? String
    }

    func request<T: Decodable>(_ endpoint: APIEndpoint, responseType: T.Type) -> AnyPublisher<T, APIError> {

        var urlComponents = URLComponents(url: endpoint.baseURL.appendingPathComponent(endpoint.path), resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = endpoint.queryParameters

        guard let url = urlComponents.url else {
            return Fail(error: APIError.badURL).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers ?? [:]

        guard let token = bearerToken else {
            return Fail(error: APIError.authenticationRequired).eraseToAnyPublisher()
        }
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResp = response as? HTTPURLResponse else {
                    throw APIError.serverError(statusCode: -1, message: "Invalid response")
                }
                if !(200..<300).contains(httpResp.statusCode) {
                    let apiMessage: String?
                    if let apiError = try? JSONDecoder().decode(TMDbError.self, from: data) {
                        apiMessage = apiError.status_message
                    } else {
                        apiMessage = String(data: data, encoding: .utf8)
                    }
                    throw APIError.serverError(statusCode: httpResp.statusCode, message: apiMessage)
                }
                return data
            }
            .mapError { error -> APIError in
                if let apiError = error as? APIError {
                    return apiError
                } else if let decodingError = error as? DecodingError {
                    return APIError.decodingError(decodingError)
                } else {
                    return APIError.unknown(error)
                }
            }
            .tryMap { data in
                try self.decoder.decode(data)
            }
            .mapError { error -> APIError in
                if let apiError = error as? APIError {
                    return apiError
                } else if let decodingError = error as? DecodingError {
                    return APIError.decodingError(decodingError)
                } else {
                    return APIError.unknown(error)
                }
            }
            .eraseToAnyPublisher()
    }

}
