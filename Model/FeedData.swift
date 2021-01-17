//
//  FeedData.swift
//  OurCoinSimple
//
//  Created by Kitty Guz on 12/10/20.
//

import Foundation
import SwiftUI
import Firebase

struct Bill: Identifiable{
    var id = UUID()
    var totalAmount: Double
    var requestAmount: Double
    var otherUserName: String
    var whoPaid: String
    var date: Date
    var nameOfBill: String
    var payBack: DarwinBoolean
}

class FeedData: ObservableObject {
    //I don't know how to make a bill list specific to every person
    @EnvironmentObject var session: SessionStore
    
    @Published var currUser = User(uid: "0", email: "jonS@winterfell.wolf", displayName: "Jon Snow", profilePic: "Jon")
    
    @Published var userDebtDic = ["Ned Stark" : 67.57, "Tyrion Lannister": -600, "Arya Stark": 0]
    
    @Published var bills: [Bill] = [Bill(totalAmount: 17.45, requestAmount: 17.45, otherUserName: "Ned Stark", whoPaid: "Ned Stark", date: Date(), nameOfBill: "Ramen", payBack: false), Bill(totalAmount: 1200, requestAmount: 600, otherUserName: "Tyrion Lannister", whoPaid: "Jon Snow", date: Date(), nameOfBill: "May Rent", payBack: false), Bill(totalAmount: 100.24, requestAmount: 50.12, otherUserName: "Ned Stark", whoPaid: "Ned Stark", date: Date(), nameOfBill: "Ramen", payBack: false)]
    
    @Published var userFriends: [User] = [
        User(uid: "1", email: "nedS@winterfell.wolf", displayName: "Ned Stark", profilePic: "Ned"),
        User(uid: "2", email: "aryaS@winterfell.wolf", displayName: "Arya Stark", profilePic: "Arya"),
        User(uid: "3", email: "tyrionL@kingslanding.lion", displayName: "Tyrion Lannister", profilePic: "Tyrion")
    ]
    
    @Published var userFriendsName: [String] = [
        "Ned Stark", "Arya Stark","Tyrion Lannister"
    ]
    
//    func addFriends(user: User) {
//        session.session!.friends!.append(user.uid)
//    }
    func addFriends(user: User) {
        userFriends.append(user)
    }
    
    func addBill(bill: Bill) {
        bills.append(bill)
    }
    
    func payBack(amountPayBack: Double, toWho: String) {
        addBill(bill: Bill(totalAmount: amountPayBack, requestAmount: 0, otherUserName: toWho, whoPaid: "Jon Snow", date: Date(), nameOfBill: "Jon PayBack", payBack: true))
        userDebtDic.updateValue(userDebtDic[toWho]! - amountPayBack, forKey: toWho)
    }
}
