//
//  HomeScreen.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 06/12/22.
//

import SwiftUI

struct HomeScreen: View {
    
    @EnvironmentObject var session: SessionStore
    
    @State var isLoading = false
    
    func doSignOut() {
        isLoading = true
        if SessionStore().signOut() {
            isLoading = false
            session.listen()
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                if (session.session != nil) {
                    Text((session.session?.email!)!)
                } else {
                    Text("no email")
                }
                
                if isLoading {
                    ProgressView()
                }
                
            }
            .navigationBarItems(trailing: HStack {
                Image(systemName: "plus.rectangle")
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .onTapGesture {
                        doSignOut()
                    }
            })
            .navigationTitle("Posts")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
