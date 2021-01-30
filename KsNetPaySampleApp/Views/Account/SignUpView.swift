//
//  SignUpView.swift
//  KsNetPaySampleApp
//
//  Created by twave on 2021/01/30.
//

import SwiftUI

struct SignUpView: View {
    @State var email: String
    @State var password: String
    @State var rePassword: String
    @State var recommendCode: String
    @State var isModal : Bool = false

    var body: some View {
//        NavigationView {

        VStack {
            GeometryReader { proxy in
                ScrollView {
                    VStack(alignment: .leading) {

                        Group {
                            Text("아이디").font(Font.system(size: 17))
                            TextField("이메일 주소", text: $email)
                            UnderLine(proxy: proxy)
                        }


                        Spacer().frame(height: 50)
                        Group {
                            Text("비밀번호").font(Font.system(size: 17))
                            SecureField("영문, 숫자 조합 8자리 이상", text: $password) {
                                print("asdfasfa")
                            }
                            UnderLine(proxy: proxy)
                            SecureField("비밀번호 재입력", text: $password) {
                                print("asdfasfa")
                            }
                            UnderLine(proxy: proxy)
                        }


                    }
                        .padding(43)

                }

//            }
                .navigationBarTitle("회원가입")
            }
            footer
        }
    }
    var footer: some View {
        ZStack {

            Button(action: {
                self.isModal = true
            }, label: {
                ZStack {
                    Color(red: 96 / 255, green: 66 / 255, blue: 249 / 255)
                        .edgesIgnoringSafeArea(.all)
                    Text("본인 인증")
                        .foregroundColor(.white)
                }
            })
            .sheet(isPresented: $isModal) {
                IdentificationView(viewModel: WebViewModel(), isModal: $isModal)
            }
        }
            .frame(height: 56)
    }


}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(email: "", password: "", rePassword: "", recommendCode: "")
    }
}

struct UnderLine: View {
    var proxy: GeometryProxy

    var body: some View {
        Rectangle()
            .foregroundColor(.gray)
            .offset(x: 0, y: -0.5)
            .frame(width: abs(proxy.size.width - 86), height: 1)
    }
}
