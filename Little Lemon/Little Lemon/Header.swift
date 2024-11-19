//
//  Header.swift
//  Little Lemon
//
//  Created by CoraciasCaudata on 15/11/2024.
//

import SwiftUI

struct Header: View {
    
    var isLoggedIn: Bool
    
    var body: some View {
        ZStack {
            Color(.highlight1).ignoresSafeArea()
            
            Image(.littleLemonLogo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 30)
            
            if isLoggedIn {
                HStack {
                    Spacer()
                    Image(systemName: "person.circle")
                        .foregroundColor(.primary1)
                        .font(.system(size: 35))
                        .padding(10)
                }
            }
        }.frame(height: 60)
    }
}

#Preview {
    Header(isLoggedIn: false)
}
