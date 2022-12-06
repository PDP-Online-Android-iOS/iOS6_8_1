//
//  SignUpScreen.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 06/12/22.
//

import SwiftUI

struct SignUpScreen: View {
    @Environment(\.presentationMode) var presentation
    
    @State var fullname = ""
    @State var email = ""
    @State var password = ""
    
    @State var isLoading = false
    
    func doSignUp() {
        isLoading = true
        SessionStore().signUp(email: email, password: password, handler: { (response, error) in
            isLoading = false
            if error != nil {
                print("User not created")
                return
            }
            print("User created")
            presentation.wrappedValue.dismiss()
        })
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Spacer()
                    Text("Create your account")
                        .font(.system(size: 30))
                        .foregroundColor(Color.red)
                    
                    TextField("Fullname", text: $fullname)
                        .frame(height: 45)
                        .padding(.leading, 10)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(30)
                    
                    TextField("Email", text: $email)
                        .frame(height: 45)
                        .padding(.leading, 10)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(30)
                    
                    SecureField("Password", text: $password)
                        .frame(height: 45)
                        .padding(.leading, 10)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(30)
                    
                    Button(action: {
                        doSignUp()
                    }, label: {
                        Spacer()
                        Text("Sign Up")
                            .foregroundColor(.white)
                        Spacer()
                    })
                    .frame(height: 45)
                    .background(Color.red)
                    .cornerRadius(30)
                    
                    Spacer()
                    
                    VStack {
                        HStack {
                            Text("Don't have an account?")
                            Button(action: {
                                self.presentation.wrappedValue.dismiss()
                            }, label: {
                                Text("Sign In").foregroundColor(.red)
                            })
                        }
                    }
                    
                }.padding()
                
                if isLoading {
                    ProgressView()
                }
            }
        }
    }
}

struct SignUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreen()
    }
}
