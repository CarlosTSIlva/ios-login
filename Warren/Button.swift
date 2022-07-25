//
//  Button.swift
//  Warren
//
//  Created by Carlos Silva on 10/07/22.
//

import SwiftUI

struct UIButton: View {
    var label: String
    var onPress: () -> Void

    var body: some View {
        Button(label) {
            onPress()
        }
        .padding()
        .background(Color(red: 157 / 255, green: 214 / 255, blue: 223 / 255))
        .cornerRadius(30)
        .frame(minWidth:350)
        .foregroundColor(.black)
    }
}
