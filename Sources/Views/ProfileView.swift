import SwiftUI

// View 2 — shows everything about the user that SearchView found.
struct ProfileView: View {
    let user: User

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                header
                details
                skills
                projects
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
        .background(Color.black.ignoresSafeArea())
        .navigationTitle(user.login)
    }

    private var header: some View {
        HStack {
            AsyncImage(url: URL(string: user.image?.versions?.medium ?? user.image?.link ?? "")) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                Image(systemName: "person.circle.fill").resizable()
            }
            .frame(width: 80, height: 80)
            .clipShape(Circle())

            VStack(alignment: .leading) {
                Text(user.displayName ?? user.login)
                    .font(.title2.bold())
                Text("Level \(user.mainLevel, specifier: "%.2f")")
                    .foregroundStyle(.secondary)
            }
        }
    }

    private var details: some View {
        VStack(alignment: .leading, spacing: 4) {
            detailRow(icon: "envelope", text: user.email)
            detailRow(icon: "phone", text: user.phone)
            detailRow(icon: "mappin.and.ellipse", text: user.location ?? "Off campus")
            detailRow(icon: "wallet.pass", text: "\(user.wallet) ₳")
            detailRow(icon: "checkmark.seal", text: "\(user.correctionPoint) evaluation points")
        }
        .font(.subheadline)
    }

    // Label(...) colors its icon and text together — this keeps the icon blue on its own.
    private func detailRow(icon: String, text: String) -> some View {
        HStack {
            Image(systemName: icon).foregroundStyle(.blue)
            Text(text)
        }
    }

    private var skills: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Skills").font(.headline)
            ForEach(user.mainSkills) { skill in
                VStack(alignment: .leading, spacing: 2) {
                    Text("\(skill.name) — \(skill.level, specifier: "%.2f")")
                        .font(.caption)
                    ProgressView(value: skill.percentage, total: 100)
                        .tint(.blue)
                }
            }
        }
    }

    private var projects: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Projects").font(.headline)
            ForEach(user.projectsUsers) { projectUser in
                HStack {
                    Text(projectUser.project.name)
                    Spacer()
                    if projectUser.validated == true {
                        Text("Passed").foregroundStyle(.green)
                    } else if projectUser.validated == false {
                        Text("Failed").foregroundStyle(.red)
                    } else {
                        Text(projectUser.status).foregroundStyle(.secondary)
                    }
                }
                .font(.subheadline)
            }
        }
    }
}
