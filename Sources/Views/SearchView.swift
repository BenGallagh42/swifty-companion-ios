import SwiftUI

// View 1 — where the user types a 42 login to search for.
struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @FocusState private var isLoginFocused: Bool // tracks whether the text field currently has the keyboard, so we can draw a visible ring around it

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Image("Logo42")
                    .renderingMode(.template) // treat the logo as a plain shape so we can tint it, instead of using its baked-in black color
                    .resizable()
                    .scaledToFit()
                    .frame(width: 72, height: 72)
                    .foregroundStyle(.white)

                Text("Swifty Companion")
                    .font(.largeTitle.bold())

                TextField("", text: $viewModel.login, prompt: Text("42 login").foregroundStyle(.gray))
                    .foregroundStyle(.black) // explicit, since white background + default text color would repeat the same invisible-text mistake
                    .tint(.blue) // the blinking cursor follows the app's white accent color by default — invisible on this white field otherwise
                    .padding()
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        // blue, not black — a black ring on a black page is invisible where it matters
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: isLoginFocused ? 3 : 0)
                    )
                    .focused($isLoginFocused)
                    .autocorrectionDisabled()
                    .onSubmit {
                        Task { await viewModel.search() }
                    }

                Button("Search") {
                    Task { await viewModel.search() }
                }
                .buttonStyle(.borderedProminent)
                .foregroundStyle(.black) // .borderedProminent doesn't auto-contrast against a plain white tint, so force readable label text
                .disabled(viewModel.login.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || viewModel.isLoading)

                if viewModel.isLoading {
                    ProgressView()
                }

                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                }

                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.ignoresSafeArea())
            .navigationDestination(item: $viewModel.foundUser) { user in
                ProfileView(user: user)
            }
        }
    }
}
