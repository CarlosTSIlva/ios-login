import Foundation
import SwiftUI
import KeychainSwift

class LoginViewModel: ObservableObject {
    @Published var email: String = "mobile_test@warrenbrasil.com"
    @Published var password: String = "Warren123!"
    @Published var loginResponse: LoginResponse?


    @Published var isLogged: Bool = false

    let keychain = KeychainSwift()

    func login(request: LoginRequest) {
        APIServices.shared.callLogin(parameters: request.dictionary ?? [:]) { [self] response in
            if let response = response {
                loginResponse = response
                keychain.set(response.accessToken, forKey: "accessToken")
                updateValidation(success: true)
            }
        }
        failure: {error in
            print(error)
        }
    }

    func deslogar( ){
        updateValidation(success: false)
        keychain.clear()
    }

    func updateValidation(success: Bool) {
        withAnimation {
            isLogged = success
        }

    }
}

