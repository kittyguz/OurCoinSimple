//
//  LoginView.swift
//  OurCoinSimple
//
//  Created by Kitty Guz on 12/10/20.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var username: String = ""
    
    @State private var loggedIn: Bool = false
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        
        // TODO: create view that accepts email/password and allows users to login or signup
        // You'll need a NavigationView and VStacks
        NavigationView {
            VStack() {
                Text("My Coin")
                    .fontWeight(.bold)
                    .font(.title)
                Image(systemName:"bitcoinsign.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.coinDarkYellow)
                VStack {
                    TextField("Name", text: $username)
                    TextField("Email", text: $email)
                        .autocapitalization(.none)
                    SecureField ("Password", text:$password)
                }.padding()
                
                VStack {
                    Button("Log In", action: {
                        logIn()
                    }).buttonStyle(Style1())
                    
                    Button("Sign Up", action: {
                        signUp()
                    }).buttonStyle(Style1())
                }.padding()
                
            }
        }
        
    }
    
    // TODO: Log in an existing user to Firebase Authentication
    func logIn() {
        session.signIn(email: email, password: password) {(result, error) in
            loggedIn = true
            if let e = error {
                print(e.localizedDescription)
            } else {
                NavigationLink(destination: ContentView()){}
                print("session.session != nil: \(session.session != nil)")
            }
        }
    }
    
    // TODO: Sign up a new user to Firebase Authentication
    func signUp() {
        session.signUp(email: email, password: password, name: username) {(result, error) in
            loggedIn = true
            if let e = error {
                print(e.localizedDescription)
            } else {
                NavigationLink(destination: ContentView()){}
                print("session.session != nil: \(session.session != nil)")
            }
        }
    }
    
    // TODO: Implement more rigorous checks
    func validEntries() -> Bool {
        if (email == session.session?.email && password != "") { return true }
        return false
    }

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView()
        }
    }
}

struct Style1: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.moneyDarkGreen, Color.moneyLightGreen]), startPoint: .leading, endPoint: .trailing))
            .foregroundColor(.white)
            .animation(.spring())
            .cornerRadius(40)
            .padding(.horizontal, 20)
    }
}

struct CustomTextField: TextFieldStyle {
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(7)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .strokeBorder(Color.sgBlue, lineWidth:1))
    }
}
}
