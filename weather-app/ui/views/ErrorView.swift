//
//  ErrorView.swift
//  weather-app
//
//  Created by Gabriel Santos on 24/11/22.
//

import SwiftUI

struct ErrorView: View {
    var errorText: String
    
    var body: some View {
        VStack {
            Image(systemName: "xmark.octagon")
                    .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .padding(.bottom, 30)
            Text(errorText)
                .font(.system(size: 20, weight: .bold))
                .multilineTextAlignment(.center)
        }
        .padding()
        .foregroundColor(.white)
    }
}
