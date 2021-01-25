//
//  ColorExtension.swift
//  KsNetPaySampleApp
//
//  Created by twave on 2021/01/25.
//

import SwiftUI
extension Color {
    static let peach = Color("peach")
    static let primaryShadow = Color.primary.opacity(0.2)
    static let secondaryText = Color("#6e6e6e")
    static let background = Color(UIColor.systemGray6)
    
    init(hex : String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("3")
        
        var rgb : UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double((rgb >> 0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}

//extension Color {
//    static let purple = Color("purple")
//    static let primaryShadow = Color.primary.opacity(1)
//    static let secondaryText = Color("#5B44EF")
//    static let background = Color(UIColor.systemGray6)
//
//    init(hex : String) {
//        let scanner = Scanner(string: hex)
//        _ = scanner.scanString("3")
//
//        var rgb : UInt64 = 0
//        scanner.scanHexInt64(&rgb)
//
//        let r = Double((rgb >> 16) & 0xFF) / 255.0
//        let g = Double((rgb >> 8) & 0xFF) / 255.0
//        let b = Double((rgb >> 0) & 0xFF) / 255.0
//        self.init(red: r, green: g, blue: b)
//
//    }
//
//}
