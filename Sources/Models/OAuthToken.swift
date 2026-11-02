import Foundation

// The response from POST https://api.intra.42.fr/oauth/token.
struct OAuthToken: Codable {
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    let createdAt: Int

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case createdAt = "created_at"
    }

    // The wall-clock moment this token stops being valid.
    var expiryDate: Date {
        Date(timeIntervalSince1970: TimeInterval(createdAt + expiresIn))
    }
}
