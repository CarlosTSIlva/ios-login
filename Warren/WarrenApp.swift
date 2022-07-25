import SwiftUI

@main
struct WarrenApp: App {
    @ObservedObject var userStateViewModel = LoginViewModel()

    var body: some Scene {
        WindowGroup {
            LoginControlView()
            .environmentObject(userStateViewModel)

        }
    }
}
