//
//  ContactCell.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 06/12/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContactCell: View {
    
    var contact: Contact
    
    var body: some View {
        HStack {
            
            WebImage(url: URL(string: contact.image!))
                .resizable()
                .frame(width: 100, height: 100)
                .scaledToFit()
            
            VStack(alignment: .leading) {
                Text(contact.name!.uppercased())
                    .foregroundColor(.red)
                    .fontWeight(.bold)
                    .padding(.bottom, 5)
                
                Text(contact.number!)
                
            }
        }
    }
}

struct ContactCell_Previews: PreviewProvider {
    static var previews: some View {
        ContactCell(contact: Contact(name: "Ogabek Matyakubov", number: "+998 93 203 73 13", image: "https://firebasestorage.googleapis.com/v0/b/fireperfect-ogabekdev.appspot.com/o/images%2F2022-12-07T10%3A04%3A56Z.jpg?alt=media&token=3931eef5-39c7-43f6-9ba8-d2be68fa8f9e"))
    }
}
