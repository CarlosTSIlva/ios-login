struct LoginRequest: Codable {
    var email: String
    var password: String
}

struct LoginResponse:Decodable {
    let accessToken: String
    let refreshToken: String
}
