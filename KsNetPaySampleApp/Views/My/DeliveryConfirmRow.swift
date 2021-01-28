//
//  DeliveryConfirmRow.swift
//  KsNetPaySampleApp
//
//  Created by twave on 2021/01/28.
//

import SwiftUI

struct DeliveryConfirmRow: View {
    @State private var blur: Bool = false
    @State private var reduction: Bool = false

    var body: some View {
        VStack {
            Image("dlwlrma")
                .blur(radius: blur ? 5 : 0)
                .animation(Animation.default.speed(2).repeatCount(6, autoreverses: true))
                .scaleEffect(reduction ? 0.7 : 1)
                .animation(Animation.default.delay(1))
                .onTapGesture {
//                withAnimation {
                    self.blur.toggle()
                    self.reduction.toggle()
//                }
            }

        }
    }
}

struct DeliveryConfirmRow_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryConfirmRow()
    }
}


extension AnyTransition {
    static var moveAndScale: AnyTransition {
        AnyTransition.move(edge: .bottom).combined(with: .scale)
    }
}
