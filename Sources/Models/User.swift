import Foundation

// Mirrors (a useful subset of) GET https://api.intra.42.fr/v2/users/:login
// Only fields Swifty Companion actually displays are modeled here.
struct User: Codable, Hashable {
    let id: Int
    let login: String
    let email: String
    let phone: String
    let displayName: String?
    let image: ProfileImage?
    let location: String?
    let wallet: Int
    let correctionPoint: Int
    let cursusUsers: [CursusUser]
    let projectsUsers: [ProjectUser]

    enum CodingKeys: String, CodingKey {
        case id, login, email, phone
        case displayName = "displayname"
        case image, location, wallet
        case correctionPoint = "correction_point"
        case cursusUsers = "cursus_users"
        case projectsUsers = "projects_users"
    }

    // The API has no single "current level" — approximate using the most recently started cursus.
    var mainLevel: Double {
        cursusUsers.last?.level ?? 0
    }

    var mainSkills: [Skill] {
        cursusUsers.last?.skills ?? []
    }
}
