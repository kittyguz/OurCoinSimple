//
//  BillPayView.swift
//  OurCoinSimple
//
//  Created by Kitty Guz on 12/10/20.
//

import SwiftUI
import UIKit

struct BillPayView: View{
    @State private var amountWishToPay: String = ""
    @State private var paymentMethod: String = ""
    @ObservedObject var data: FeedData
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var amount : Double
    var user: User
    
    var body: some View {
        NavigationView {
            VStack {
                Text("TOTAL: $\(amount, specifier: "%.2f")")
                    .font(.title)
                    .padding()
                
                Spacer()
                
                VStack {
                    Text("How much did you pay?")
                        .modifier(JustifyLeft(withPadding: false))
                    TextField("Enter", text: $amountWishToPay)
                    
                    Text("What payment method did you use?")
                        .modifier(JustifyLeft(withPadding: false))
                    TextField("Enter", text: $paymentMethod)
                }.padding()
                
                Spacer()
                          
                Button("Pay", action: {
                    //change the amount in the debtDictionary
                    //add a new bill that titles xxx paid back
                    data.payBack(amountPayBack: Double(amountWishToPay)!, toWho: user.displayName)
                    self.presentationMode.wrappedValue.dismiss()
                })
                .buttonStyle(Style1())
                .padding()
            }.navigationBarHidden(true)
            
        }.navigationBarTitle("Payment", displayMode: .inline)
    }
}

struct BillPay_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello BillPayView")
    }
}

struct Style1: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(.black), Color(.white)]), startPoint: .leading, endPoint: .trailing))
            .foregroundColor(.white)
            .animation(.spring())
            .cornerRadius(40)
            .padding(.horizontal, 20)
    }
}
