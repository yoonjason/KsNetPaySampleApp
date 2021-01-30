//
//  IdentificationView.swift
//  KsNetPaySampleApp
//
//  Created by twave on 2021/01/30.
//

import SwiftUI
import WebKit

struct IdentificationView: View {
    @ObservedObject var viewModel : WebViewModel
    @State var bar = true
    @Binding var isModal : Bool
    var url = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb"
    
    var body: some View {
        VStack {
            WebView(url: url, viewModel: viewModel)
//            https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb
        }
        .navigationBarTitle("본인 확인")
        .navigationBarItems(trailing:
        Button(action:
    {
        isModal = false
    }, label: {
        Image("btnActionsheetClose")
    })
    )
        
    }
}

struct IdentificationView_Previews: PreviewProvider {
    static var previews: some View {
        IdentificationView(viewModel: WebViewModel(), isModal: .constant(true))
    }
}
