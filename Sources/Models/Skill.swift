import Foundation

// One skill inside a cursus (e.g. "Rigor", "Unix").
struct Skill: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let level: Double

    // Level as a 0-100 percentage, for the progress bar.
    var percentage: Double {
        max(0, min(level / 20.0, 1.0)) * 100
    }
}
