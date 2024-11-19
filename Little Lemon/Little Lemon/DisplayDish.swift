//
//  DisplayDish.swift
//  Little Lemon
//
//  Created by CoraciasCaudata on 17/11/2024.
//

import SwiftUI

struct DisplayDish: View {
    private var dish: Dish
    init(_ dish: Dish) {
        self.dish = dish
    }
    
    var body: some View {
    
        let title = dish.title
        let price = dish.price
        let imageURL = URL(string: dish.image ?? "")
        HStack{
            
            VStack(alignment: .leading) {
                Text(title ?? "N/A")
                    .padding([.top, .bottom], 7)
                    .fontWeight(.bold)
                Text("$\(price ?? "N/A")")
                    .padding([.top, .bottom], 7)
                    .italic()
            }
            
            Spacer()
            
            AsyncImage(url: imageURL) { phase in
                if let image = phase.image {
                 image.resizable()
                        .frame(width: 80, height: 80, alignment: .center)
                        .aspectRatio(contentMode: .fill)
                        .border(Color(.primary2), width: 2)
                        
                } else if phase.error != nil {
                 Image(systemName: "photo")
                  .font(.title)
                  .foregroundStyle(.secondary)
                } else {
                 ProgressView()
                        .controlSize(.regular)
                }
            }
        }
        .contentShape(Rectangle())
    }
}


#Preview {
    // DisplayDish()
}
