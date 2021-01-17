//
//  User.swift
//  OurCoinSimple
//
//  Created by Kitty Guz on 12/10/20.
//

import Foundation

struct User: Hashable{
    
    var uid: String
    var email: String
    var displayName: String
    var friends: [String]?
    var profilePic: String
    var debtDictionary: Dictionary<String, Double>
    var peopleToPay: Int
    var peopleNeedCoinFrom: Int
    
    init(uid: String, email: String, displayName: String, friends: [String], profilePic: String, debtDictionary: Dictionary<String, Double>) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
        self.friends = friends
        self.profilePic = "emptyProfile"
        self.debtDictionary = debtDictionary
        
        let numToPay = self.debtDictionary.filter{key, value in
            return value > 0
        }
        let numNeedFrom = self.debtDictionary.filter{key, value in
            return value < 0
        }
        self.peopleToPay = numToPay.count
        self.peopleNeedCoinFrom = numNeedFrom.count
    }
    
    init(uid: String, email: String, displayName: String, profilePic: String) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
        self.friends = []
        self.profilePic = "emptyProfile"
        self.debtDictionary = [:]
        
        let numToPay = self.debtDictionary.filter{key, value in
            return value > 0
        }
        let numNeedFrom = self.debtDictionary.filter{key, value in
            return value < 0
        }
        self.peopleToPay = numToPay.count
        self.peopleNeedCoinFrom = numNeedFrom.count
    }
}
