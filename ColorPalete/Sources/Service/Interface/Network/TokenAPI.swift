//
//  TokenAPI.swift
//  TokenAPI
//
//  Created by Triet M1 Macbook Pro on 19.7.2021.
//

import Foundation

enum TokenAPI {
    case token(request: TokenRequest)
}

extension TokenAPI: APIRequestProtocol {
    var path: String {
        switch self {
        case .token:
            return "/v1/login"
        }
    }

    var method: RequestMethod {
        switch self {
        case .token:
            return .post
        }
    }

    var headers: ReaquestHeaders? {
        defaultHeaders
    }

    var parameters: RequestParameters? {
        switch self {
        case let .token(request):
            return request.dictionary
        }
    }

    var queryParameters: RequestQueryParameters? {
        nil
    }

    var requiredAccessToken: Bool {
        false
    }
}
