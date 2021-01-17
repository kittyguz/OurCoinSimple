//
//  ContentView.swift
//  OurCoinSimple
//
//  Created by Kitty Guz on 12/10/20.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    // Keep track of which tab is currently selected
    @State private var selectedTab = "home"
    
    // Keep track of the user's authentication status
    @EnvironmentObject var session: SessionStore
    
    // FeedData objects
    @ObservedObject var data: FeedData = FeedData()
      
    func getUserAuth() {
        session.configureUserAuth()
    }
   
    var body: some View {
        // TODO: TabView here.
        // Use a Group.
        // Use the @EnvironmentObject session var to determine user's authentication status and which view should be shown.
        // Call the getUserAuth function onAppear to obtain up-to-date authentication status.
        Group {
            if session.session != nil {
                //HomeView(data: data)
                NavigationView {
                    TabView{
                        HomeView(data: data)
                            .tabItem {
                                Image(systemName: "house")
                                Text("Home")
                            }.navigationBarHidden(true)
                        MyFriendsView(data: data)
                            .tabItem{
                                Image(systemName: "person")
                                Text("My Friends")
                            }.navigationBarHidden(true)
                    }
                }
            } else {
                LoginView()
            }
        }.onAppear(perform: {
            getUserAuth()
        })
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SessionStore())
    }
}

