//
//  AddPostScreen.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 06/12/22.
//

import SwiftUI

struct AddPostScreen: View {
    @Environment(\.presentationMode) var presentation
    
    @ObservedObject var database = RealtimeStore()
    
    @State var firstname = ""
    @State var lastname = ""
    @State var number = ""
    
    @State var isLoading = false
    
    func addNewContact() {
        isLoading = true
        let contact = Contact(name: "\(firstname) \(lastname)", number: number)
        database.storeContact(contact: contact, completion: { status in
            isLoading = false
            if status {
                self.presentation.wrappedValue.dismiss()
            }
        })
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    TextField("Firstname", text: $firstname)
                        .frame(height: 50)
                        .padding(.leading, 10)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    
                    TextField("Lastname", text: $lastname)
                        .frame(height: 50)
                        .padding(.leading, 10)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    
                    TextField("Phone", text: $number)
                        .frame(height: 50)
                        .padding(.leading, 10)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    
                    Button {
                        addNewContact()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Add")
                                .foregroundColor(.white)
                            Spacer()
                        }
                    }
                    .frame(height: 50)
                    .background(Color.red)
                    .cornerRadius(8)
                    
                    Spacer()
                }.padding()
                if isLoading {
                    ProgressView()
                }
            }
            .accentColor(.red)
            .tint(Color.red)
            .navigationBackButton(color: .red, text: "Posts")
            .navigationTitle("Add Contact")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AddPostScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddPostScreen()
    }
}
