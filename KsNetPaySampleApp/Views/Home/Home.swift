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
    @State private var isPresented = false
    @State var alertMessage: String = ""
    let testStatus = CurrentValueSubject<Bool, Error>(true)

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
                        testStatus.sink(receiveCompletion: { completion in
                            switch completion {
                            case .finished :
                                print("finished")
                            case .failure(let error) :
                                print(error)
                            }
                        }, receiveValue: { (value) in
                            print("값이 도착 했읍니다. \(value)")
                        })
                        testStatus.send(true)
                    }
                        .frame(width: proxy.size.width, height: 50)
                        .foregroundColor(.white)
                        .background(Color.purple)

                }

                    .navigationBarTitle("로그인")
            }
                .padding()
        }
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name(rawValue: "isLogined"))) { [self] notification in
            if let jwt = notification.object as? String {
                print(jwt)
            }
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
