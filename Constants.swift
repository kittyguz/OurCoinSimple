//
//  Constants.swift
//  OurCoinSimple
//
//  Created by Kitty Guz on 12/10/20.
//

import Foundation
import SwiftUI

let screenWidth = UIScreen.main.bounds.width
extension Color {
   static let sgBlue: Color = Color(red: 116/255, green: 147/255, blue: 255/255)
   static let moneyLightGreen: Color = Color(red: 119/255, green: 188/255, blue: 0/255)
   static let moneyDarkGreen: Color = Color(red: 0/255, green: 132/255, blue: 22/255)
   static let moneyMediumGreen: Color = Color(red: 18/255, green: 160/255, blue: 0/255)
   static let coinDarkYellow: Color = Color(red: 239/255, green: 171/255, blue: 0/255)
   static let coinLightYellow: Color = Color(red: 255/255, green: 255/255, blue: 0/255)
    
   static let sgYellow: Color = Color(red: 255/255, green: 178/255, blue: 58/255)
   static let postBG: Color = Color(red: 245/255, green: 245/255, blue: 245/255)
   static let postNavBar: Color = Color(red: 236/255, green: 236/255, blue: 236/255)
}

extension Font {
   static let monseratt_bold = Font.custom("Montserrat-Bold", size: 60.0)
   static let zapfino = Font.custom("Zapfino", size: 16.0)
}
