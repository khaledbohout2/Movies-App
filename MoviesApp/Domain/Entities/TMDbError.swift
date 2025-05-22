
import Foundation

struct TMDbError: Decodable, Error {
    let status_code: Int
    let status_message: String
    let success: Bool?

    var localizedDescription: String {
        return status_message
    }
}
