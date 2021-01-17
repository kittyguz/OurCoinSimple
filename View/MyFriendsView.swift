//
//  MyFriendsView.swift
//  OurCoinSimple
//
//  Created by Kitty Guz on 12/10/20.
//

import SwiftUI
import UIKit

struct MyFriendsView: View {
    @State var searchText: String = ""
    @ObservedObject var data : FeedData
    @State var go = false
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        NavigationView{
            ScrollView {
                LazyVStack {
                    ForEach(data.userFriends, id: \.self) { friend in
                        VStack {
                            ContactCell(data: data, user: friend)
                        }.modifier(JustifyLeft(withPadding: false))
                    }
                }
            }.navigationBarTitle("Friends")
        }
    }
}


struct ContactCell: View {
    @State var go = false
    @ObservedObject var data: FeedData
    var user: User
    
    var body: some View {
        HStack {
            NavigationLink(destination: CoinWithMeView(user: user, data: data), isActive: $go) {}
            Button(action:{
                    go.toggle()
            }, label: {
                HStack {
                    Image(user.profilePic)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                        .clipShape(Circle())
                        .frame(width: 80, height: 80)
                    VStack {
                        Text(user.displayName ?? "N/A")
                            .modifier(JustifyLeft(withPadding: false))
                        Text(user.email ?? "")
                            .modifier(JustifyLeft(withPadding: false))
                    }
                }
            }).padding()
        }
    }
    
}

struct JustifyLeft: ViewModifier {

   var withPadding: Bool

   func body(content: Content) -> some View {
      HStack {
         content
         Spacer()
      }
      //.padding(.horizontal)
      //.padding(.top)
   }
}
