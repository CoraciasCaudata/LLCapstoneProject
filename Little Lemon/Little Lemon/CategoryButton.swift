//
//  CategoryButton.swift
//  Little Lemon
//
//  Created by CoraciasCaudata on 15/11/2024.
//

import SwiftUI

struct CategoryButton: View {
    var title: String
    let indexTrigger: Int
    @Binding var index: Int
    
    var body: some View {
        Button(action: {
            if index != indexTrigger {
                index = indexTrigger
            }
        }, label: {
            Text(title)
                .font(.system(size: 16, weight: .semibold, design: .none))
                .frame(maxWidth: .infinity)
        })
        .frame(height: 30)
        
        .foregroundColor(index == indexTrigger ? .highlight1 : .highlight2)
        .background(index == indexTrigger ? .highlight2 : .highlight1)
        .cornerRadius(30)
    }
}




#Preview {
    @Previewable @State var index = 0
    
    HStack{
        CategoryButton(title: "Starters", indexTrigger: 0, index: $index)
        CategoryButton(title: "Mains", indexTrigger: 1, index: $index)
        CategoryButton(title: "Desserts", indexTrigger: 2, index: $index)
        CategoryButton(title: "All", indexTrigger: 3, index: $index)
    }
    
}
