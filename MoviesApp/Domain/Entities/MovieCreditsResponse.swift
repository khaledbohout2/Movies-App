
import Foundation

struct MovieCreditsResponse: Codable {
    let id: Int
    let cast: [CastMember]
    let crew: [CrewMember]
}

struct CastMember: Codable, Identifiable {
    let id: Int
    let name: String
    let popularity: Double
    let knownForDepartment: KnownForDepartment?
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id, name, popularity
        case knownForDepartment = "known_for_department"
        case profilePath = "profile_path"
    }
}

struct CrewMember: Codable, Identifiable {
    let id: Int
    let name: String
    let popularity: Double
    let knownForDepartment: KnownForDepartment
    let job: String
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id, name, popularity, job
        case knownForDepartment = "known_for_department"
        case profilePath = "profile_path"
    }
}

enum KnownForDepartment: Codable, Equatable {
    case acting
    case directing
    case unknown(String)

    var rawValue: String {
        switch self {
        case .acting: return "Acting"
        case .directing: return "Directing"
        case .unknown(let value): return value
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)

        switch value {
        case "Acting":
            self = .acting
        case "Directing":
            self = .directing
        default:
            self = .unknown(value)
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}

struct Cast {
    let actors: [CastMember]
    let directors: [CrewMember]
}
