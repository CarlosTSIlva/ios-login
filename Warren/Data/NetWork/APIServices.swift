import Alamofire
import KeychainSwift

struct APIServices {
    public static let shared = APIServices()

    let baseUrl = "https://enigmatic-bayou-48219.herokuapp.com/api/v2"
    let keychain = KeychainSwift()

    func callLogin(parameters: Parameters? = nil, success: @escaping (_ result: LoginResponse?) -> Void, failure: @escaping (_ failureMsg: FailureMessage) -> Void) {
        let headers = HTTPHeaders()
        APIManager.shared.callAPI(serveURL: "\(baseUrl)/account/login", method: .post, headers: headers, parameters: parameters, success: { response in
            do {
                if let data = response.data {
                    let LoginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                    success(LoginResponse)
                }
            } catch {
                failure(FailureMessage(error.localizedDescription))
            }
        },
        failure: { error in
            failure(FailureMessage(error))
        })
    }

    func getWallets(parameters: Parameters? = nil, success: @escaping (_ result: PortfolioResponse?) -> Void, failure: @escaping (_ failureMsg: FailureMessage) -> Void) {
        let headers: HTTPHeaders = [
            "access-token": keychain.get("accessToken") ?? ""
        ]
        
        APIManager.shared.callAPI(serveURL: "\(baseUrl)/portfolios/mine", method: .get, headers: headers, parameters: parameters, success: { response in
            do {
                if let data = response.data {
                    let PortfolioResponse = try JSONDecoder().decode(PortfolioResponse.self, from: data)
                    success(PortfolioResponse)
                }
            } catch {
                failure(FailureMessage(error.localizedDescription))
            }
        },
                                  failure: { error in
            failure(FailureMessage(error))
        })
    }

}
