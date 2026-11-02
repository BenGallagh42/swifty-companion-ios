import Foundation

// Fetches and caches the app-level OAuth2 token so we reuse it across queries.
final class TokenManager {
    private var currentToken: OAuthToken?

    // Returns a valid access token, reusing the cached one if it hasn't expired yet.
    func validAccessToken() async throws -> String {
        if let token = currentToken, token.expiryDate > Date() {
            return token.accessToken
        }
        let freshToken = try await fetchNewToken()
        currentToken = freshToken
        return freshToken.accessToken
    }

    // POST /oauth/token using our app's own credentials (Client Credentials grant).
    private func fetchNewToken() async throws -> OAuthToken {
        var request = URLRequest(url: URL(string: "https://api.intra.42.fr/oauth/token")!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        let body = "grant_type=client_credentials&client_id=\(Secrets.clientUID)&client_secret=\(Secrets.clientSecret)"
        request.httpBody = body.data(using: .utf8)

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        return try JSONDecoder().decode(OAuthToken.self, from: data)
    }
}
