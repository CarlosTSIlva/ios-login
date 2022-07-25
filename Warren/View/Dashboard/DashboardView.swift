//
//  DashboardView.swift
//  Warren
//
//  Created by Carlos Silva on 09/07/22.
//

import Foundation
import SwiftUI

struct DashboardView: View {
    @StateObject var dashboardModel = DashboardModel()
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        VStack {
            if dashboardModel.portfolioResponse?.portfolios != nil {
                List {
                    UIButton(
                        label: "Deslogar",
                        onPress: { loginViewModel.deslogar() }
                    )
                    .listRowBackground(Color(red: 160 / 255, green: 132 / 255, blue: 207 / 255))
                    .listRowSeparator(Visibility.hidden)
                    ForEach(dashboardModel.portfolioResponse!.portfolios, id: \._id) { portfolio  in
                        CardContent(portfolio: portfolio)
                    }
                    .listRowSeparator(Visibility.hidden)
                    .listRowBackground(Color(red: 160 / 255, green: 132 / 255, blue: 207 / 255))

                }
                .listStyle(.plain)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
        }

        .onAppear {

            dashboardModel.getWallet()
            print("carregou")
        }
        .onChange(of: loginViewModel.isLogged, perform: { newValue in
            print("erro \(newValue)")
        })
        .background(Color(red: 160 / 255, green: 132 / 255, blue: 207 / 255))
    }
}

struct CardContent: View {
    let portfolio: WalletItens

    var body: some View {
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
        .frame(maxWidth: 350, minHeight: 250, maxHeight: 250, alignment: .topLeading)
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
