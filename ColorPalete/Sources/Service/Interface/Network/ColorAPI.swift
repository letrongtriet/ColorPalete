//
//  ColorAPI.swift
//  ColorAPI
//
//  Created by Triet M1 Macbook Pro on 19.7.2021.
//

import Foundation

enum ColorAPI {
    case getColors(storageId: String)
    case createStorage(request: ColorCreationRequest)
    case addColor(request: ColorCreationRequest, storageId: String)
    case deleteStorage(storageId: String)
}

extension ColorAPI: APIRequestProtocol {
    var path: String {
        switch self {
        case .createStorage:
            return "/v1/storage"
        case let .getColors(storageId):
            return "/v1/storage/\(storageId)"
        case let .addColor(_, storageId):
            return "/v1/storage/\(storageId)"
        case let .deleteStorage(storageId):
            return "/v1/storage/\(storageId)"
        }
    }

    var method: RequestMethod {
        switch self {
        case .createStorage:
            return .post
        case .getColors:
            return .get
        case .addColor:
            return .put
        case .deleteStorage:
            return .delete
        }
    }

    var headers: ReaquestHeaders? {
        switch self {
        case .createStorage:
            return defaultHeaders
        case .getColors:
            return [:]
        case .addColor:
            return defaultHeaders
        case .deleteStorage:
            return [:]
        }
    }

    var parameters: RequestParameters? {
        switch self {
        case let .createStorage(request):
            return request.dictionary
        case .getColors:
            return nil
        case let .addColor(request, _):
            return request.dictionary
        case .deleteStorage:
            return nil
        }
    }

    var queryParameters: RequestQueryParameters? {
        nil
    }

    var requiredAccessToken: Bool {
        switch self {
        case .createStorage:
            return true
        case .getColors:
            return true
        case .addColor:
            return true
        case .deleteStorage:
            return true
        }
    }
}
