//
//  SessionStore.swift
//  OurCoinSimple
//
//  Created by Kitty Guz on 12/10/20.
//

import Foundation
import SwiftUI
import Firebase
import Combine
import FirebaseDatabase

class SessionStore: ObservableObject {
    @Published var existError = false
    @Published var didChange = PassthroughSubject<SessionStore, Never>()
    @Published var session: User? { didSet { self.didChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?
    var ref = Database.database().reference(fromURL: "https://ourcoinsimple-default-rtdb.firebaseio.com/")
    
    func configureUserAuth() {
        // Monitor authentication changes using firebase
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                // If we have a user, create a new user model
                print("Got user: \(user)")
                let userID = Auth.auth().currentUser?.uid
                self.ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                    // Get user value
                    let value = snapshot.value as? NSDictionary
                    let username = value?["username"] as? String ?? "Reset Username"
                    let email = value?["email"] as? String ?? "default email"
                    let friends = value?["friends"] as? [String] ?? []
                    let profilePic = value?["profilePic"] as? String ?? "Ned"
                    let debtDic = value?["debtDictionary"] as? Dictionary<String, Double> ?? [:]
                    
                    //set current session
                    self.session = User(uid: userID!, email: email, displayName: username, friends: friends, profilePic: profilePic, debtDictionary: debtDic)
                    print("came in")
                  }) { (error) in
                    print("did not come in")
                    print(error.localizedDescription)
                }
            } else {
                // If we don't have a user, set our session to nil
                self.session = nil
            }
        }
    }

    //Sign up a new user with Firebase Authentication
    func signUp(email: String, password: String, name: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().createUser(withEmail: email, password: password, completion: {authData, error in
            if error == nil {
                let userData = ["username": name, "email": email, "friends": [], "profile pic": "", "debtHistory": [:]] as [String : Any]
                self.ref.child("users").child((authData?.user.uid) as! String).updateChildValues(userData, withCompletionBlock: {(err, ref) in
                    if err != nil {
                        print(err)
                        return
                    }
                    print("Saved user successfully into Firebase db")
                })
            } else {
                print(error?.localizedDescription)
            }
        })
    }

    // Sign in an existing user with Firebase AUthentication
    func signIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        do {
            try Auth.auth().signIn(withEmail: email, password: password, completion: handler)
        } catch {
            existError = true
        }
        
    }

    // TODO: Sign out the current user
    func signOut() {
        do{
            try Auth.auth().signOut()
            self.session = nil
            NavigationLink(destination: LoginView()){}
        }catch{
            print(error.localizedDescription)
            existError = true
        }
        
    }
    
    /// Stop listening to our authentication change handler
    func unbind () {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
}

struct SessionStore_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
