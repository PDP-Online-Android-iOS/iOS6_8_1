//
//  SignInScreen.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 06/12/22.
//

import SwiftUI

struct SignInScreen: View {
    
    @EnvironmentObject var session: SessionStore
    @State var isSheet = false
    
    @State var email = "ogabekdev@gmail.com"
    @State var password = "12345678"
    
    @State var isLoading = false
    
    func doSignIn() {
        isLoading = true
        if !email.isEmpty && !password.isEmpty  {
            SessionStore().signIn(email: email, password: password, handler: { (response, error) in
                isLoading = false
                if error != nil {
                    print("Check Email or password")
                    return
                }
                print("User signed in")
                session.listen()
            })
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Spacer()
                    Text("Welcome Back")
                        .font(.system(size: 30))
                        .foregroundColor(Color.red)
                    
                    TextField("Email", text: $email)
                        .frame(height: 45)
                        .padding(.leading, 10)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(30)
                    
                    TextField("Password", text: $password)
                        .frame(height: 45)
                        .padding(.leading, 10)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(30)
                    
                    Button(action: {
                        doSignIn()
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
                            Button {
                                isSheet = true
                            } label: {
                                Text("Sign In")
                                    .foregroundColor(.red)
                            }.sheet(isPresented: $isSheet, content: {
                                SignUpScreen()
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

struct SignInScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreen()
    }
}
