import Foundation

// One project attempt from a user's history (finished, failed, or in progress).
struct ProjectUser: Codable, Identifiable, Hashable {
    let id: Int
    let finalMark: Int?
    let status: String
    let validated: Bool?
    let project: ProjectInfo

    enum CodingKeys: String, CodingKey {
        case id
        case finalMark = "final_mark"
        case status
        case validated = "validated?" // real API key includes the "?"
        case project
    }

    // True once the attempt is fully finished (pass or fail — not still in progress).
    var isFinished: Bool { status == "finished" }
}

// Just the project's own id/name, nested inside each ProjectUser.
struct ProjectInfo: Codable, Hashable {
    let id: Int
    let name: String
}
