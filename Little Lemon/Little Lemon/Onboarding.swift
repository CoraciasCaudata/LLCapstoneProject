//
//  Onboarding.swift
//  Little Lemon
//
//  Created by CoraciasCaudata on 11/11/2024.
//

import SwiftUI

let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email key"
let kIsLoggedIn = "kIsLoggedIn"



struct Onboarding: View {
    
    @State private var selectedView = 1
    let maxNumberOfScreens = 3
    
    @State var inputText: String = ""
    
    @FocusState private var isFocused: Bool
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    
    @State var isLoggedIn: Bool = false
    @State var showFormInvalidMessage = false
    @State var errorMessage = ""
    
    
    private func refresh() {
        firstName = ""
        lastName = ""
        email = ""
        selectedView = 1
    }
    
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                Header(isLoggedIn: false)
                
                Spacer()
                
                VStack {
                    switch selectedView {
                    case 1:
                        OnboardingView(data: OnboardingData(systemImageName: "fork.knife", title: "Welcome to Little Lemon ", subtitle: "What is your first name?   (1/3)"))
                    case 2:
                        OnboardingView(data: OnboardingData(systemImageName: "person.fill.questionmark", title: "Tell us more...", subtitle: "What is your last name?   (2/3)"))
                    default:
                        OnboardingView(data: OnboardingData(systemImageName: "envelope.circle", title: "One last thing", subtitle: "What is your email address?   (3/3)"))
                    }
                }
                
                TextField("Answer here...", text: $inputText)
                    .padding(30)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Spacer()
                
                Button(action: {switch selectedView {
                case 1:
                    if validateFirstName() {
                        selectedView += 1
                    }
                case 2:
                    if validateLastName() {
                        selectedView += 1
                    }
                default:
                    if validateEmail() {
                        logInUser()
                    }
                }
                    inputText = ""
                }, label: {
                    Text(selectedView == maxNumberOfScreens ? "🍋 Done! 🍋" : "Next")
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
            .background(Color.primary1)
            
            .alert("ERROR", isPresented: $showFormInvalidMessage, actions: {
                Button("OK", role: .cancel) { }
            }, message: {
                Text(self.errorMessage)
            })
            
            .navigationDestination(isPresented: $isLoggedIn) {
                Home()
            }
        }
        
        .onAppear() {
            if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                isLoggedIn = true
            }
        }
    }
    
    private func validateFirstName() -> Bool {
        firstName = inputText
        guard isValid(name: firstName) else {
            var invalidNameMessage = ""
            if firstName.isEmpty || !isValid(name: firstName) {
                invalidNameMessage = "Names can only contain letters and must have at least 3 characters\n\n"
            }
            self.errorMessage = "Found these errors in the form:\n\n \(invalidNameMessage)"
            
            showFormInvalidMessage.toggle()
            return false
        }
        return true
    }
    
    private func validateLastName() -> Bool {
        lastName = inputText
        guard isValid(name: lastName) else {
            var invalidNameMessage = ""
            if lastName.isEmpty || !isValid(name: lastName) {
                invalidNameMessage = "Names can only contain letters and must have at least 3 characters\n\n"
            }
            self.errorMessage = "Found these errors in the form:\n\n \(invalidNameMessage)"
            
            showFormInvalidMessage.toggle()
            return false
        }
        return true
    }
    
    private func validateEmail() -> Bool {
        email = inputText
        print(email)
        guard isValid(email: email) else {
            
            var invalidEmailMessage = ""
            if !email.isEmpty || !isValid(email: email) {
                invalidEmailMessage = "The e-mail is invalid and cannot be blank."
            }
            self.errorMessage = "Found these errors in the form:\n\n \(invalidEmailMessage)"
            
            showFormInvalidMessage.toggle()
            return false
        }
        return true
    }
    
    
    private func logInUser() {
        UserDefaults.standard.set(firstName, forKey: kFirstName)
        UserDefaults.standard.set(lastName, forKey: kLastName)
        UserDefaults.standard.set(email, forKey: kEmail)
        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
        
        isLoggedIn = true
        refresh()
    }
    
    func isValid(name: String) -> Bool {
        guard !name.isEmpty,
              name.count > 2
        else { return false }
        for chr in name {
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") && !(chr == " ") ) {
                return false
            }
        }
        return true
    }
    
    func isValid(email:String) -> Bool {
        guard !email.isEmpty else { return false }
        let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
        return emailValidationPredicate.evaluate(with: email)
    }
}

#Preview {
    Onboarding()
}
