import Alamofire

public typealias FailureMessage = String

public class APIManager {
    public static let shared = APIManager()

    func callAPI(serveURL: String, method: HTTPMethod = .get, headers: HTTPHeaders? = nil, parameters: Parameters? = nil, success: @escaping ((AFDataResponse<Any>) -> Void), failure: @escaping ((FailureMessage) -> Void)) {
        guard let url = URLComponents(string:  "\(serveURL)") else {
            failure("Invalid Url")
            return
        }

        // network request
        AF.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success:
                    success(response)
                case let .failure(err):
                    failure(err.localizedDescription)
                }
            }
    }
}
