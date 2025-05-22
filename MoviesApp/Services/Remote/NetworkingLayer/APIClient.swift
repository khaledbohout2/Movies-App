
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

        // MARK: - DEBUG PRINTS
        print("🌐 [API REQUEST]")
        print("➡️ URL: \(url.absoluteString)")
        print("➡️ METHOD: \(request.httpMethod ?? "")")
        print("➡️ HEADERS:")
        request.allHTTPHeaderFields?.forEach { print("   \($0.key): \($0.value)") }

        if let queryItems = urlComponents.queryItems {
            print("➡️ QUERY PARAMS:")
            queryItems.forEach { print("   \($0.name): \($0.value ?? "")") }
        }

        return URLSession.shared.dataTaskPublisher(for: request)
            .handleEvents(receiveOutput: { data, response in
                if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
                   let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
                   let jsonString = String(data: jsonData, encoding: .utf8) {
                    print("✅ [RESPONSE JSON]:\n\(jsonString)")
                } else {
                    print("❌ Failed to parse response JSON")
                }
            }, receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("❗️[API ERROR]: \(error.localizedDescription)")
                }
            })
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
            .tryMap { data -> T in
                let decoder = JSONDecoder()
                do {
                    return try decoder.decode(T.self, from: data)
                } catch let decodingError as DecodingError {
                    print("❌ [DECODING ERROR]")
                    switch decodingError {
                    case .typeMismatch(let type, let context):
                        print("🔍 Type Mismatch: \(type) - \(context.debugDescription)")
                        print("➡️ Coding Path: \(context.codingPath.map(\.stringValue).joined(separator: " -> "))")
                    case .valueNotFound(let type, let context):
                        print("🔍 Value Not Found: \(type) - \(context.debugDescription)")
                        print("➡️ Coding Path: \(context.codingPath.map(\.stringValue).joined(separator: " -> "))")
                    case .keyNotFound(let key, let context):
                        print("🔍 Key Not Found: \(key.stringValue) - \(context.debugDescription)")
                        print("➡️ Coding Path: \(context.codingPath.map(\.stringValue).joined(separator: " -> "))")
                    case .dataCorrupted(let context):
                        print("🔍 Data Corrupted - \(context.debugDescription)")
                        print("➡️ Coding Path: \(context.codingPath.map(\.stringValue).joined(separator: " -> "))")
                    @unknown default:
                        print("🔍 Unknown Decoding Error")
                    }
                    throw decodingError
                } catch {
                    print("❌ Unknown Error during decoding: \(error.localizedDescription)")
                    throw error
                }
            }
            .eraseToAnyPublisher()
    }

}
