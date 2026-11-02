import Foundation

// One entry from the user's cursus_users array — progress within a single curriculum.
struct CursusUser: Codable, Hashable {
    let level: Double
    let skills: [Skill]
    let cursus: Cursus
}

// The curriculum itself (e.g. "42cursus", "C Piscine").
struct Cursus: Codable, Hashable {
    let id: Int
    let name: String
}
