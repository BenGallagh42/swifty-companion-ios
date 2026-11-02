import Foundation

// The user's profile picture, in one or more sizes.
struct ProfileImage: Codable, Hashable {
    let link: String?
    let versions: ProfileImageVersions?
}

// The same picture, resized — pick whichever fits where you're displaying it.
struct ProfileImageVersions: Codable, Hashable {
    let large: String?
    let medium: String?
    let small: String?
    let micro: String?
}
