import Foundation

// Holds the search screen's state and talks to the network on its behalf.
@MainActor
final class SearchViewModel: ObservableObject {
    @Published var login: String = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var foundUser: User?

    private let apiClient = APIClient()

    func search() async {
        let trimmedLogin = login.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !trimmedLogin.isEmpty, !isLoading else { return }

        errorMessage = nil
        foundUser = nil
        isLoading = true

        do {
            foundUser = try await apiClient.fetchUser(login: trimmedLogin)
        } catch APIError.userNotFound {
            errorMessage = "No student found with login \"\(trimmedLogin)\"."
        } catch {
            errorMessage = "Something went wrong. Check your connection and try again."
        }

        isLoading = false
    }
}
