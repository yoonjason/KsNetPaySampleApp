//
//  ProductWebView.swift
//  KsNetPaySampleApp
//
//  Created by twave on 2021/01/26.
//

import SwiftUI
import WebKit


struct ProductWebView: View {
    @Binding var isModel: Bool
    @ObservedObject var viewModel : WebViewModel
    @State var bar = true

    var body: some View {
        NavigationView {
            VStack {
                WebView(url: "https://kspay.ksnet.to/store/KSPayMobileV1.4/KSPayPWeb.jsp", viewModel: viewModel)
//                HStack {
//                    Text(bar ? "Before" : "After")
//                    
//                    Button(action: {
//                        self.viewModel.foo.send(true)
//                    }){
//                        Text("보내기")
//                    }
//                }

            }
            .onReceive(self.viewModel.bar.receive(on: RunLoop.main)){ (value) in
                self.bar = value
            }
                .navigationBarTitle("상품구매하기")
                .navigationBarItems(trailing:
                Button(action:
            {
                isModel = false
            }, label: {
                Image("btnActionsheetClose")
            })
            )
        }
    }
}

struct ProductWebView_Previews: PreviewProvider {
    static var previews: some View {
        ProductWebView(isModel: .constant(true), viewModel: WebViewModel())
    }
}
