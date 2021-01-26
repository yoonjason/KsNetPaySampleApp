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
    @ObservedObject var viewModel: SignViewModel
    @State private var isPresented = false
    @State var alertMessage: String = ""
    let testStatus = CurrentValueSubject<Bool, Error>(true)
    @State private var token = ""
    @State var bag = Set<AnyCancellable>()

    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                ScrollView {
                    VStack {
                        TextField("이메일 입력해주세요.", text: $viewModel.userId)
                            .frame(width: proxy.size.width, height: 50, alignment: .center)
                        HorizontalLine(color: .black)
                        SecureField("비밀번호를 입력해주세요.", text: $viewModel.userPwd)
                            .frame(width: proxy.size.width, height: 50, alignment: .center)
                        HorizontalLine(color: .black)
                        customDivider
                        Rectangle()
                            .foregroundColor(.green)
                            .cornerRadius(10)
                            .frame(width: proxy.size.width, height: 50)
                            .overlay (
                            Text("로그인하기")
                                .foregroundColor(.white)
                        )
                            .onTapGesture {
                            viewModel.isLogined.sink(receiveCompletion: { completion in
                                print(completion)
                            }, receiveValue: { (value) in
                                print("뷰에서 값 받아오냐 씨발\(value)")

                            }).store(in: &bag)
                            viewModel.emailLogin()

                        }
                        Text("login Token : "+token).font(Font.system(size: 12))
                        Text(alertMessage)
                    }
                }
            }
                .navigationBarTitle("로그인")
                .padding()
        }
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name(rawValue: "pushData"))) { [self] notification in
            print("ContentView로 들어왔나요? \(notification.userInfo)")
            if let aps = notification.userInfo!["mediaUrl"] as? String {
                print(aps)

            }
            alertMessage = String("\(notification.userInfo)")
            isPresented = true
        }
            .alert(isPresented: $isPresented) {
            Alert(title: Text("title"), message: Text(alertMessage), primaryButton: .destructive(Text("확인")) {
                self.isPresented = false
            }, secondaryButton: .cancel())
        }
            .onAppear {
            viewModel.signToken.sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { token in
                self.token = token
            })
                .store(in: &bag)
        }

    }

    var customDivider: some View {
        Color.primary.opacity(0.0)
            .frame(maxWidth: .infinity, maxHeight: 15)
    }

    var tokenView: some View {
        Text(token)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(viewModel: SignViewModel())
    }
}
