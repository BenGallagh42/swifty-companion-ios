import Foundation

// Errors specific to talking to the 42 API.
enum APIError: Error {
    case userNotFound
    case invalidResponse
}

// Fetches a single user's profile from the 42 API.
struct APIClient {
    private let tokenManager = TokenManager()

    func fetchUser(login: String) async throws -> User {
        let accessToken = try await tokenManager.validAccessToken()

        guard let encodedLogin = login.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
              let url = URL(string: "https://api.intra.42.fr/v2/users/\(encodedLogin)") else {
            throw APIError.invalidResponse
        }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        if httpResponse.statusCode == 404 {
            throw APIError.userNotFound
        }
        guard httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }

        return try JSONDecoder().decode(User.self, from: data)
    }
}
