import Foundation

class DashboardModel: ObservableObject {
    @Published var portfolioResponse: PortfolioResponse?

    func getWallet() {
        APIServices.shared.getWallets() { [self] response in
            if let response = response {
                portfolioResponse = response
            }
        }
    failure: {error in
        print(error)
    }
}
}

