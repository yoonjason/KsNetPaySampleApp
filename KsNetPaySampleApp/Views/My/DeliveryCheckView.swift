//
//  DeliveryCheckView.swift
//  KsNetPaySampleApp
//
//  Created by twave on 2021/01/28.
//

import SwiftUI

struct DeliveryCheckView: View {
    var body: some View {
//        NavigationView {
            GeometryReader { proxy in
                ScrollView(.vertical) {
                    VStack {
                        HStack {
                            Image("dunk")
                                .resizable()
                                .frame(width: 100, height: 100)
//                            Spacer()
                            VStack(spacing: 5) {
                                Text("Nike Dunk Grey-Red").modifier(CustomTextAlignment())
                                Text("197,400 원").modifier(CustomTextAlignment())
                                Text("Size : 265").modifier(CustomTextAlignment())
                                Text("배송중")
                                    .foregroundColor(.allNewPurple)
                                    .modifier(CustomTextAlignment())
                            }
                        }
                            .padding()
                        darkerDivider
                    }
                }
            }
            .navigationBarTitle("주문/배송 확인", displayMode: .inline)
//                .navigationBarTitle("주문/배송 확인")
//        }
    }

    var darkerDivider: some View {
        Color.primary.opacity(0.1)
            .frame(maxWidth: .infinity, maxHeight: 5)
    }
}

struct DeliveryCheckView_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryCheckView()
    }
}


struct CustomTextAlignment : ViewModifier {
    
    func body(content: Content) -> some View {
        content.frame(maxWidth: .infinity, alignment: .leading)
    }
}
