//
//  SignViewModel.swift
//  KsNetPaySampleApp
//
//  Created by twave on 2021/01/26.
//

import Foundation
import Alamofire
import Combine

class SignViewModel: ObservableObject, Identifiable {

    @Published var userId = ""
    @Published var userPwd = ""
//    @Published var isSignin = false
    var isLogined = CurrentValueSubject<Bool, Never>(false)

//    var isSignedPublisher : AnyPublisher<Bool, Never> {
//
//    }

    func emailLogin(_ userAgreePath: String? = "E", userId: String, userPwd: String, uuid : String? = "Simulator") {
        let param = ["userAgreePath": "E", "userId": userId, "userPwd": userPwd, "uuid":uuid]
        let urls = "https://app-api.iminfintech.co.kr/api/v1/member/login"
        AF.request(urls, method: .post, parameters: param).response(completionHandler: { (response) in
            print(response)
        })
    }

    func emailLogin2(_ userAgreePath: String? = "E", uuid : String? = "Simulator") {
        let param = ["userAgreePath": "E", "userId": userId, "userPwd": userPwd, "uuid":uuid]
        let urls = "https://app-api.iminfintech.co.kr/api/v1/member/login"
        print(param)
//        DataResponse<TokenModel, AFError>
        AF.request(urls, method: .post, parameters: param).responseJSON(completionHandler: { [self] (response) in
            switch response.result {
            case .success(let obj) :
                if let data = try? JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted) {
                    if let jsonData = try? JSONDecoder().decode(TokenModel.self, from: data) {
                        if let jwt = jsonData.token {
                            print(jwt)
                            isLogined.send(true)
                            
//                            let stream = isLogined.sink(receiveValue: { value in
//                                print("#@#@#@#@#\(value)")
//                            })
//
//                            print("stream \(stream)")
                        }
                    }
                }
            case .failure(let error) :
                isLogined.send(false)
                print(error.localizedDescription)
            }
        })
    }
}
