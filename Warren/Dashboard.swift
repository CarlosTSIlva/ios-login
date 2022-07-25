//
//  Dashboard.swift
//  Warren
//
//  Created by Carlos Silva on 09/07/22.
//

import Foundation

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
