//
//  ContactCell.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 06/12/22.
//

import SwiftUI

struct ContactCell: View {
    
    var contact: Contact
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(contact.name!.uppercased())
                .foregroundColor(.red)
                .fontWeight(.bold)
                .padding(.bottom, 5)
            
            Text(contact.number!)
            
        }
    }
}

struct ContactCell_Previews: PreviewProvider {
    static var previews: some View {
        ContactCell(contact: Contact(name: "Ogabek Matyakubov", number: "+998 93 203 73 13"))
    }
}
