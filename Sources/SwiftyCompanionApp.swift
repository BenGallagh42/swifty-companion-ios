import SwiftUI

// SwiftUI apps start here — the @main attribute marks this as the entry point,
// replacing the old AppDelegate/storyboard setup from UIKit projects.
@main
struct SwiftyCompanionApp: App {
    var body: some Scene {
        WindowGroup {
            SearchView()
                .preferredColorScheme(.dark) // forces dark mode app-wide — white text/icons are the default in dark mode, so we barely need to set colors by hand
        }
    }
}
