//
//  Globals.swift
//  KsNetPaySampleApp
//
//  Created by twave on 2021/01/26.
//

import Foundation
import SwiftUI
import Alamofire

let brandPurple = "#6042f9"

class Globals {
    static let sharedInstance = Globals()
    
    var uuid = ""
    var pushToken = ""
    var initParameters = [String:String]()
    var appVersionInfo = Bundle.main.infoDictionary!["CFBundleShortVersionString"]! as? String
    var headers:HTTPHeaders = ["channel":"ios"]
    
    func initfff(){
        print(#function)
        let url = "https://app-api.iminfintech.co.kr/api/v1/init/app/info"
        print(initParameters)
        AF.request(url, method: .post, parameters: initParameters).responseJSON(completionHandler: { [self] response in
            print(response)
        })
    }
}


 struct HorizontalLineShape: Shape {
    func path(in rect: CGRect) -> Path {
        let fill = CGRect(x: .zero, y: .zero, width: rect.size.width, height: rect.size.height)
        var path = Path()
        path.addRoundedRect(in: fill, cornerSize: CGSize(width: 2, height: 2))
        return path
    }
}

 struct HorizontalLine: View {
    
    var color: Color
    
    var body: some View {
        HorizontalLineShape()
            .fill(color)
            .frame(minWidth: .zero, maxWidth: .infinity, minHeight: 1.0, maxHeight: 1.0)
    }
}
