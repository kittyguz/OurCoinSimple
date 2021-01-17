//
//  CoinWithMeView.swift
//  OurCoinSimple
//
//  Created by Kitty Guz on 12/10/20.
//

import SwiftUI
import UIKit

struct CoinWithMeView: View{
    var user: User
    @ObservedObject var data: FeedData
    @EnvironmentObject var session: SessionStore
    @State var payBill = false
    
    var body: some View {
            VStack {
                ScrollView{
                    LazyVStack(spacing: 5){
                        HStack {
                            Text("Date")
                            Spacer()
                            Text("Total Cost")
                            Spacer()
                            Text("You Pay")
                        }.padding()
                        ForEach(data.bills.sorted(by: {$0.date < $1.date})) {bill in
                            if (bill.otherUserName == user.displayName) {
                                BillLine(bill: bill)
                            }
                        }
                    }.modifier(JustifyLeft(withPadding: false))
                }
                
                Spacer()
                
                Text("TOTAL: $\(data.userDebtDic[user.displayName ?? "N/A"] ?? 0, specifier: "%.2f")")
                NavigationLink(destination: BillPayView(data: data, amount: data.userDebtDic[user.displayName ?? "N/A"] ?? 0, user: user ), isActive: $payBill) {}
                Button("Pay", action: {
                    payBill.toggle()
                }).buttonStyle(Style1())
            }.navigationBarTitle(user.displayName ?? "N/A" + "& My Coins", displayMode: .inline)
        }
}

//Display a line of bill with date and amounts
struct BillLine: View {
    
    var bill: Bill
    
    static let postDateFormat: DateFormatter = {
         let formatter = DateFormatter()
         formatter.dateStyle = .long
         return formatter
     }()
    
     var body: some View {
        HStack {
            VStack {
                Text(BillLine.postDateFormat.string(from: bill.date))
                    .font(.caption2)
                Text(bill.nameOfBill)
                    .font(.caption)
                    .frame(width: 100)
                    .padding()
                    .background(Color(.black))
                    .foregroundColor(.white)
                    .animation(.spring())
                    .padding(.horizontal, 20)
            }
            Spacer()
            Text(String(bill.totalAmount))
            Spacer()
            if (bill.whoPaid == "Jon Snow") {
                Text(String(-bill.requestAmount))
            } else {
                Text(String(bill.requestAmount))
            }
        }
     }
    
}

struct CoinWithMeView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello Coin With Me")
    }
}

