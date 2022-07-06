import Alamofire
import SwiftUI
import KeychainSwift

struct ContentView: View {

    let keychain = KeychainSwift()
    @State var usuario: String = "mobile_test@warrenbrasil.com"
    @State var senha: String = "Warren123!"
    @State var showErrorLogin: String? = nil
    @State var logado: Bool = false
    @State var portfolios: PortfolioResponse? = nil

    var body: some View {
        VStack {
            if logado {
                VStack {
                    ScrollView {
                        Button("Deslogar") {
                            logado = false
                            keychain.clear()
                        }
                        if portfolios?.portfolios != nil {
                            ForEach(portfolios!.portfolios, id: \._id) { portfolio  in
                                VStack(alignment: .leading) {
                                    if portfolio.goalAmount != nil {
                                        let metaValor = portfolio.goalAmount
                                        let totalInvestido = portfolio.totalBalance
                                        let porcentagem = ((Double(totalInvestido) / Double(metaValor ?? 0)) * 100)
                                        Spacer().frame(height: 4)
                                        ProgressView(value: porcentagem > 100 ? 100 : porcentagem, total: 100)
                                            .accentColor(.green)
                                    }

                                        Text(portfolio.name)
                                            .bold()
                                            .font(.title)
                                            .foregroundColor(.white)


                                        Text(String(portfolio.totalBalance.formatted(.currency(code: "BRL"))))
                                            .bold()
                                            .font(.title)
                                            .foregroundColor(.white)

                                }
                                .frame(width: 350, height: 250, alignment: .topLeading)
                                .padding()
                                .background(
                                    AsyncImage(
                                        url: URL(string: portfolio.background.small),
                                        content: { image in
                                            image
                                                .aspectRatio(contentMode: .fit)
                                                .symbolRenderingMode(.palette)
                                                .background(.black)
                                                .opacity(0.8)

                                        }, placeholder: {
                                            Color.gray
                                    })
                                )
                                .cornerRadius(20)
                            }
                        }
                    }
                }.onAppear {
                    getWallets()
                }
            }
            else {
                VStack(alignment: .center) {
                    TextField("Usuario", text: $usuario)
                        .padding()
                        .border(.secondary)
                        .background(.white)
                    SecureField("Senha", text: $senha).padding().border(.secondary)
                        .background(.white)

                    if showErrorLogin != nil {
                        Text(showErrorLogin!).bold()
                    }

                    Button("Logar") {
                        testePost()
                    }
                }
                    .frame(maxHeight: .infinity)
                    .padding()
//                    .background(.green)

            }
        }.onAppear {
            let authToken = keychain.get("accessToken")
            if authToken != nil {
                logado = true
            }
        }
    }

    let baseUrl = "https://enigmatic-bayou-48219.herokuapp.com/api/v2"

    func getWallets() {
        let authToken = keychain.get("accessToken")
        let headers: HTTPHeaders = [
            "access-token": authToken ?? ""
        ]
        let request = AF.request("\(baseUrl)/portfolios/mine", method: .get, headers: headers)
        request.responseDecodable(of: PortfolioResponse.self) { response in
            DispatchQueue.main.async {
                guard response.value?.portfolios != nil else {
                    keychain.clear()
                    logado = false
                    return
                }
            }

            portfolios = response.value
            logado = true
        }
    }

    func testePost() {
        let params = [
            "email": usuario,
            "password": senha
        ]
        let request = AF.request("\(baseUrl)/account/login", method: .post, parameters: params, encoding: JSONEncoding.default) {  urlRequest in
            let data = try! JSONSerialization.data(withJSONObject: params, options: [])


            urlRequest.httpBody = data
        }

        request.responseDecodable(of: LoginResponse.self) { response in
            DispatchQueue.main.async {
                guard response.value?.accessToken != nil else {
                    senha = ""
                    showErrorLogin = "Error ao fazer login tente novamente"

                    return
                }
                logado = true
                keychain.set(response.value!.accessToken, forKey: "accessToken")
            }

        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct LoginResponse:Decodable {
    let accessToken: String
    let refreshToken: String
}

struct PortfolioResponse: Decodable {
    let portfolios: [WalletItens]
}

struct WalletItens: Decodable {

    let _id: String
    let name: String
    let totalBalance: Double
    let goalAmount: Int?
    let goalDate: String
    let background: WalletImages
}

struct WalletImages: Decodable {
    let thumb: String
    let small: String
    let full: String
    let regular: String
    let raw: String
}
