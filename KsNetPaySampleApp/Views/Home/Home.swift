//
//  Home.swift
//  KsNetPaySampleApp
//
//  Created by twave on 2021/01/26.
//

import SwiftUI
import Combine

struct Home: View {
    @State var email: String = ""
    @State var pass: String = ""
    @ObservedObject var viewModel = SignViewModel()


    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                VStack {
                    TextField("이메일 입력해주세요.", text: $viewModel.userId)
                        .frame(width: proxy.size.width, height: 50, alignment: .center)
                    HorizontalLine(color: .black)
                    SecureField("비밀번호를 입력해주세요.", text: $viewModel.userPwd)
                        .frame(width: proxy.size.width, height: 50, alignment: .center)
                    HorizontalLine(color: .black)
                    customDivider
                    Button("로그인 하기") {
                        viewModel.emailLogin2()
                    }
                        .frame(width: proxy.size.width, height: 50)
                        .foregroundColor(.white)
                        .background(Color.purple)
                    
                }

                    .navigationBarTitle("로그인")
            }
                .padding()
        }
            .onAppear {

        }
    }

    var customDivider: some View {
        Color.primary.opacity(0.0)
            .frame(maxWidth: .infinity, maxHeight: 15)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
