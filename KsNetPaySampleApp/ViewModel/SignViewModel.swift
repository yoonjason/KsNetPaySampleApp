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
//    let isLogined = PassthroughSubject<Bool, Never>()

//    var isSignedPublisher : AnyPublisher<Bool, Never> {
//
//    }
    
    init() {
        isLogined.send(false)
    }

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
                            isLogined.send(true)
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "isLogined"), object: jwt)
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
