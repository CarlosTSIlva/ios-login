//
//  LoginControl.swift
//  Warren
//
//  Created by Carlos Silva on 09/07/22.
//

import Foundation
import KeychainSwift
import SwiftUI

struct LoginControlView: View {
    let keychain = KeychainSwift()
    @EnvironmentObject var loginViewModel: LoginViewModel


    var body: some View {
        VStack {
            if loginViewModel.isLogged {
                DashboardView()
            } else {
                LoginView()
            }
        }
            .onAppear(
                perform: {
                    if (keychain.get("accessToken") != nil) {
                        loginViewModel.isLogged = true
                    }
                }
            )
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .center
            )
            .background(Color(red: 160 / 255, green: 132 / 255, blue: 207 / 255))
        
    }
}
