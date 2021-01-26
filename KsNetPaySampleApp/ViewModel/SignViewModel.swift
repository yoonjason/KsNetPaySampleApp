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

    private var cancellables : [AnyCancellable] = []
    
    @Published var userId = ""
    @Published var userPwd = ""
    var signToken = PassthroughSubject<String, Never>()

//    var isLogined = CurrentValueSubject<Bool, Never>(false)
    var isLogined = PassthroughSubject<Bool, Never>()
    var isTested = PassthroughSubject<Bool, Never>()
    

    func emailLogin(_ userAgreePath: String? = "E", uuid : String? = "Simulator") {
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
                            signToken.send(jwt)
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "isLogined"), object: jwt)
                        }
                    }
                }
                
                isLogined.send(true)
            case .failure(let error) :
                isLogined.send(false)
                print(error.localizedDescription)
            }
        })
    }
}
