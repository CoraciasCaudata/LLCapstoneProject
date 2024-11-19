//
//  OnboardingView.swift
//  Little Lemon
//
//  Created by CoraciasCaudata on 18/11/2024.
//

import SwiftUI

import SwiftUI

struct OnboardingData: Identifiable {
    let id = UUID()
    let systemImageName: String
    let title: String
    let subtitle: String
}



struct OnboardingView: View {
    let data: OnboardingData
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: data.systemImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 200, maxHeight: 200)
                .padding(.bottom)
                .foregroundColor(.primary2)
                .shadow(color: .secondary1, radius: 12)
            
            VStack(alignment: .leading) {
                Text(data.title)
                    .bold()
                    .font(.title)
                    .padding(.bottom)
                
                Text(data.subtitle)
            }
        }
        .padding()
        .frame(maxHeight: 300)
        .foregroundColor(.highlight1)
    }
}

#Preview {
    
    @Previewable @State var text = ""
    @Previewable @FocusState var isFocused: Bool
    
    OnboardingView(data: OnboardingData(systemImageName: "person.fill.questionmark", title: "Tell us about yourself...", subtitle: "What is your first name?"))
        .background(.primary1)
}

