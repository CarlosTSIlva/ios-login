//
//  ContentView.swift
//  Warren
//
//  Created by Carlos Silva on 30/06/22.
//

import Alamofire
import SwiftUI

struct ContentView: View {
    @State var usuario: String = "mobile_test@warrenbrasil.com"
    @State var senha: String = "Warren123!"
    var showPassword: Bool = false

    var body: some View {
        ScrollView {
            TextField("Usuario", text: $usuario).padding()
            SecureField("Senha", text: $senha).padding()

            Button(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/) {
                testePost()
            }
        }
    }
    let url = "https://enigmatic-bayou-48219.herokuapp.com/api/v2/account/login"
    let parameters = [
        "email": "mobile_test@warrenbrasil.com",
        "password": "Warren123!"
    ]
    func testePost() {
        let request = AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody)
        // 2
        request.responseJSON { (data) in
            print(data)
        }

    }




}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
