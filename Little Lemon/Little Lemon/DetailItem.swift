//
//  DetailItem.swift
//  Little Lemon
//
//  Created by Robert Eyre on 27/11/2024.
//

import SwiftUI

struct DetailItem: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    let dish: Dish
    
    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .clipShape(Rectangle())
            .frame(minHeight: 150)
            Text(dish.title ?? "")
                .font(.subheadline)
                .foregroundColor(.primary1)
            Spacer(minLength: 20)
            Text(dish.descriptionOfDish ?? "")
            Spacer(minLength: 10)
            Text("$" + (dish.price ?? ""))
                .foregroundColor(.primary1)
                .monospaced()
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .ignoresSafeArea()
    }
}

struct DetailItem_Previews: PreviewProvider {
    static var previews: some View {
        DetailItem(dish: PersistenceController.oneDish())
    }
}
