//
//  TokenModel.swift
//  KsNetPaySampleApp
//
//  Created by twave on 2021/01/26.
//

import Foundation

struct TokenModel: Codable {
    var token: String?
    var code: String?
    var message: String?

    enum CodingKeys: String, CodingKey {
        case token = "data"
        case code = "code"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        token = try values.decode(String.self, forKey: .token)
        code = try values.decode(String.self, forKey: .code)
        message = try values.decode(String.self, forKey: .message)
    }

}
