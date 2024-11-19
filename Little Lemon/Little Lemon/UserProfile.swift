//
//  UserProfile.swift
//  Little Lemon
//
//  Created by CoraciasCaudata on 11/11/2024.
//

import SwiftUI

struct UserProfile: View {
    
    @State private var showingAlert = false
    
    let firstName = UserDefaults.standard.string(forKey: kFirstName)
    let lastName = UserDefaults.standard.string(forKey: kLastName)
    let email = UserDefaults.standard.string(forKey: kEmail)
    
    let dismiss: DismissAction?
    init(dismiss: DismissAction? = nil) {
        self.dismiss = dismiss
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            Header(isLoggedIn: true)
                .frame(minHeight: 60)
            
            VStack {
                ZStack {
                    Rectangle().fill(.highlight1)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Personal Information")
                                .font(.system(size: 28, weight: .medium, design: .none))
                                .padding([.top, .leading], 25)
                            Spacer()
                        }
                        
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .foregroundColor(.primary1)
                                .font(.system(size: 80))
                                .padding(EdgeInsets(top: 10, leading: 40, bottom: 15, trailing: 0))
                        }
                        
                        VStack(alignment: .leading) {
                            Text("First Name:")
                                .font(.system(size: 20, weight: .bold, design: .none))
                            Text(firstName ?? "John")
                            
                            Text("Last Name:")
                                .font(.system(size: 20, weight: .bold, design: .none))
                                .padding(.top, 20)
                            Text(lastName ?? "Doe")
                            
                            Text("Email:")
                                .font(.system(size: 20, weight: .bold, design: .none))
                                .padding(.top, 20)
                            Text(email ?? "johndoe@gmail.com")
                        }
                        .padding(.horizontal, 40)
                        
                        Spacer()
                        
                        VStack(spacing: 30){
                            Button(action: {
                                showingAlert = true
                            }, label: {
                                Text("Subscribe to our Newsletter!")
                                    .font(.system(size: 20, weight: .semibold, design: .none))
                                    .frame(maxWidth: .infinity)
                            })
                            .padding(10)
                            .foregroundColor(.highlight1)
                            .background(.secondary1)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.secondary2, lineWidth: 2)
                            )
                            .alert("Thank you for subscribing!", isPresented: $showingAlert) {
                                Button("OK", role: .cancel) { }
                            }
                        }
                        .padding(30)
                        .shadow(color: .gray, radius: 2)
                        
                        Spacer()
                    }
                }
                .cornerRadius(30)
            }
            .shadow(color: .gray, radius: 10)
            .padding()
            
            Button(action: {
                logOut()
            }, label: {
                Text("Log Out")
                    .font(.system(size: 20, weight: .semibold, design: .none))
                    .frame(maxWidth: .infinity)
            })
            .padding()
            .foregroundColor(.highlight2)
            .background(.primary2)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.secondary1, lineWidth: 2)
            )
            .padding(EdgeInsets(top: 20, leading: 60, bottom: 60, trailing: 60))
            
            Spacer()
        }
    }
    
    func logOut() {
        UserDefaults.standard.set(false, forKey: kIsLoggedIn)
        if let dismiss { dismiss() }
    }
}

#Preview {
    UserProfile()
}
