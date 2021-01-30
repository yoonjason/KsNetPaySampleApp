//
//  UIViewModifiers.swift
//  KsNetPaySampleApp
//
//  Created by twave on 2021/01/30.
//

import Foundation
import SwiftUI
import UIKit

struct NavigationBarColor: ViewModifier {

    let backgroundColor : UIColor
    let tintColor : UIColor
    let shadowColor : UIColor
    
    init(backgroundColor: UIColor, tintColor: UIColor, shadowColor : UIColor) {
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
        self.shadowColor = shadowColor
    }

    func body(content: Content) -> some View {
            content
                .onAppear() {
                    let coloredAppearance = UINavigationBarAppearance()
                    coloredAppearance.configureWithOpaqueBackground()
                    
                    coloredAppearance.backgroundColor = backgroundColor
                    coloredAppearance.backgroundImage?.withTintColor(backgroundColor)
                    coloredAppearance.titleTextAttributes = [.foregroundColor: tintColor]
                    coloredAppearance.largeTitleTextAttributes = [.foregroundColor: tintColor]
                    coloredAppearance.shadowColor = shadowColor
                                   
//                    UINavigationBar.appearance().standardAppearance = coloredAppearance
//                    UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
//                    UINavigationBar.appearance().compactAppearance = coloredAppearance
                    UINavigationBar.appearance().tintColor = tintColor
                    UINavigationBar.appearance().barTintColor = backgroundColor
                    UINavigationBar.appearance().backgroundColor = backgroundColor
                    UINavigationBar.appearance().shadowImage = UIImage().withTintColor(shadowColor)
                }
    }
}


struct PressActions: ViewModifier {
   var onPress: () -> Void
   var onRelease: () -> Void
   
   func body(content: Content) -> some View {
       content
           .simultaneousGesture(
               DragGesture(minimumDistance: 0)
                   .onChanged({ _ in
                       onPress()
                   })
                   .onEnded({ _ in
                       onRelease()
                   })
           )
   }
}

struct ButtonPressImageStyle: ButtonStyle {
    
    @State var isPressed = false
    var normalImage : String
    var pressedImage : String
    
    init(normalImage: String, pressImage: String) {
        self.normalImage = normalImage
        self.pressedImage = pressImage
    }

    
    func makeBody(configuration: Self.Configuration) -> some View {
        Image(configuration.isPressed ? self.pressedImage : self.normalImage)
    }
}
 
struct ListSeparatorStyle: ViewModifier {
    
    let style: UITableViewCell.SeparatorStyle
    
    func body(content: Content) -> some View {
        content
            .onAppear() {
                UITableView.appearance().separatorStyle = self.style
            }
    }
}
 
 
