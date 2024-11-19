//
//  Hero.swift
//  Little Lemon
//
//  Created by CoraciasCaudata on 16/11/2024.
//

import SwiftUI

struct Hero: View {
    var body: some View {
        ZStack {
            Color(.primary1)
                //.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                
                Text("Little Lemon")
                    .font(.custom("Georgia", size: 40))
                    .padding([.leading])
                    .foregroundColor(.primary2)
                    .frame(maxHeight: 50)
                    
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Chicago")
                            .font(.custom("Georgia", size: 25))
                            .foregroundColor(.highlight1)
                            .padding([.leading])
                        
                        Spacer()
                        
                        Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist")
                            
                            .font(.system(size: 16, weight: .medium, design: .none))
                            .foregroundColor(.highlight1)
                            .minimumScaleFactor(0.5)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding([.leading])
                    }.frame(maxHeight: 75)
                    Spacer()
                    Image("food-closeup")
                        .resizable()
                        .cornerRadius(5)
                        .aspectRatio(contentMode: .fit)
                        .padding([.trailing])
                        .shadow(radius: 5)
                        .frame(maxHeight: 150)
                    
                    
                } .padding(.vertical, 10)
                
                Spacer()
            }
        }
        .frame(height: 200)
    }
}

#Preview {
    Hero()
}
