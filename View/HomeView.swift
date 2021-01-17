//
//  HomeView.swift
//  OurCoinSimple
//
//  Created by Kitty Guz on 12/10/20.
//

import SwiftUI
import UIKit

struct HomeView: View{
    @ObservedObject var data: FeedData
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        VStack {
            Image("Jon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipped()
                .clipShape(Circle())
                .frame(width: 200, height: 200)
            ZStack {
                Rectangle()
                    .foregroundColor(Color.moneyMediumGreen)
                    .frame(width: screenWidth, height: 80)
                HStack {
                    RecordView(title: "Friends", number: session.session?.friends?.count ?? 0)
                    RecordView(title: "PayTo", number: session.session?.peopleToPay ?? 0)
                    RecordView(title: "NeedFrom", number: session.session?.peopleNeedCoinFrom ?? 0)
                }
            }
            
            VStack {
                Text("Username: \(session.session?.displayName ?? "N/A")")
                Text("Email: \(session.session?.email ?? "N/A")")
            }
            
            Spacer()
            
            Button("Log Out", action: {
                session.signOut()
            }).padding()
            .buttonStyle(LoginView.Style1())
        }
    }
}

struct RecordView: View {
    var title: String
    var number: Int
    
    var body: some View {
        VStack{
            Text(title)
                .font(.subheadline)
                .bold()
                .frame(width: (screenWidth-80)/3, height: 10)
                .padding(.all, 10)
                .background(Color.white.opacity(0.5))
                .cornerRadius(20)
            Text(String(number))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello HomwView")
    }
}
