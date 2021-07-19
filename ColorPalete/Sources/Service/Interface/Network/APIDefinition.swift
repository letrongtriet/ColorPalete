//
//  APIDefinition.swift
//  APIDefinition
//
//  Created by Triet M1 Macbook Pro on 19.7.2021.
//

import Foundation

typealias ReaquestHeaders = [String: String]
typealias RequestParameters = [String: Any?]
typealias RequestQueryParameters = [String: String]
typealias Closure<T> = (T) -> Void

public var defaultHeaders: [String: String] {
    ["Content-Type": "application/json"]
}

protocol APIRequestProtocol {
    var path: String { get }
    var method: RequestMethod { get }
    var headers: ReaquestHeaders? { get }
    var parameters: RequestParameters? { get }
    var queryParameters: RequestQueryParameters? { get }
    var requiredAccessToken: Bool { get }
}

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum APIError: Error, Equatable {
    case invalidUrlRequest
    case invalidResponse
    case noResponse
    case badRequest(String?)
    case serverError(String?)
    case parseError(String?)
    case url(Error?)
    case unknown
    case httpStatusCode(_ code: Int, _ data: Data?,
                        _ response: HTTPURLResponse)
    case underlying(Error?)
    case decoding(Error?, Data?)
    
    case noInternetConnection

    case invalidToken

    static func == (lhs: APIError, rhs: APIError) -> Bool {
        lhs.localizedDescription == rhs.localizedDescription
    }
}

