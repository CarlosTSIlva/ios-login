import SwiftUI

struct LoginView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        VStack(alignment: .center) {

            //
            AsyncImage(url: URL(string: "https://obomprogramador.com/swift/images/swift-og.png")) { image in
                image.resizable()
            } placeholder: {
                Color.red
            }
            .frame(width: 128, height: 128)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .padding()
            TextField("Usuario", text: $loginViewModel.email)
                .padding()
                .border(.secondary)
                .background(.white)
                .cornerRadius(15)
            
            SecureField("Senha", text: $loginViewModel.password)
                .padding()
                .border(.secondary)
                .background(.white)
                .cornerRadius(15)
            UIButton(
                label: "Logar",
                onPress: {
                    let loginRequest = LoginRequest(email: loginViewModel.email, password: loginViewModel.password)
                    loginViewModel.login(request: loginRequest)
                }
            )

        }
            .padding()
    }
}


