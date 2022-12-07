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
    @ObservedObject var storage = StorageStore()
    
    @State var defImage = UIImage(imageLiteralResourceName: "img_picker")
    @State var firstname = ""
    @State var lastname = ""
    @State var number = ""
    
    @State var pickedImage: UIImage? = nil
    @State var showImagePicker: Bool = false
    
    @State var isLoading = false
    
    func addNewContact(photo: String) {
        isLoading = true
        let contact = Contact(name: "\(firstname) \(lastname)", number: number, image: photo)
        database.storeContact(contact: contact, completion: { status in
            isLoading = false
            if status {
                self.presentation.wrappedValue.dismiss()
            }
        })
    }
    
    func uploadImage() {
        isLoading = true
        storage.uploadImage(pickedImage ?? defImage, completion: { url in
            isLoading = false
            let urlString = url?.absoluteString
            print(urlString!)
            addNewContact(photo: urlString! )
        })
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    
                    Image(uiImage: pickedImage ?? defImage)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .scaledToFit()
                        .onTapGesture {
                            self.showImagePicker = true
                        }.sheet(isPresented: $showImagePicker, onDismiss: {
                            self.showImagePicker = false
                        }, content: {
                            ImagePicker(image: self.$pickedImage, isShown: self.$showImagePicker)
                        })
                    
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
//                        addNewContact()
                        uploadImage()
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
