//
//  NetworkManager.swift
//  NetworkManager
//
//  Created by Triet M1 Macbook Pro on 19.7.2021.
//

import Foundation
import UIKit

public class NetworkManager {
    // MARK: - Private properties

    let baseUrlString: String
    let localStorageService: LocalStorageInterface

    // MARK: - Init

    init(
        baseUrlString: String,
        localStorageService: LocalStorageInterface
    ) {
        self.baseUrlString = baseUrlString
        self.localStorageService = localStorageService
    }

    // MARK: - Private methods

    func executeRequest<T: Codable>(
        _ request: URLRequest,
        completion: @escaping (Result<T, APIError>) -> Void
    ) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  let data = data
            else {
                DispatchQueue.main.async {
                    completion(.failure(.noResponse))
                }
                return
            }

            guard (200 ... 299).contains(response.statusCode) else {
                if let error = error as? URLError {
                    DispatchQueue.main.async {
                        completion(.failure(.url(error)))
                    }
                }
                else {
                    DispatchQueue.main.async {
                        completion(.failure(.httpStatusCode(response.statusCode, data, response)))
                    }
                }
                return
            }

            if response.statusCode == 204 {
                DispatchQueue.main.async {
                    completion(.success(true as! T))
                }
                return
            }

            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
                return
            }
            catch {
                if let error = error as? DecodingError {
                    DispatchQueue.main.async {
                        completion(.failure(.decoding(error, data)))
                    }
                }
                else {
                    DispatchQueue.main.async {
                        completion(.failure(.underlying(error)))
                    }
                }
            }
        }.resume()
    }

    func createURLRequest(from requestType: APIRequestProtocol) -> URLRequest? {
        let urlString = baseUrlString + requestType.path

        guard var url = URL(string: urlString) else {
            return nil
        }

        if let queryParameters = requestType.queryParameters {
            var queryItems = [URLQueryItem]()
            for (name, value) in queryParameters {
                queryItems.append(.init(name: name, value: value))
            }
            if var urlComps = URLComponents(string: urlString) {
                urlComps.queryItems = queryItems
                if let queryUrl = urlComps.url {
                    url = queryUrl
                    print(url.absoluteString)
                }
            }
        }

        var request = URLRequest(url: url, timeoutInterval: 60)
        request.httpMethod = requestType.method.rawValue

        if let parameters = requestType.parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        }

        if let headers = requestType.headers {
            request.allHTTPHeaderFields = headers
        }

        return request
    }

    func refreshAccessTokenIfNeededAndMakeRequest<T: Codable>(
        _ requestType: APIRequestProtocol,
        completion: @escaping (Result<T, APIError>) -> Void
    ) {
        guard var request = createURLRequest(from: requestType)
        else {
            completion(.failure(.invalidUrlRequest))
            return
        }

        if requestType.requiredAccessToken {
            if let token = localStorageService.getToken() {
                request.addValue(token, forHTTPHeaderField: "Authorization")
                executeRequest(request, completion: completion)
            } else {
                refreshAccessToken { result in
                    switch result {
                    case let .success(response):
                        self.localStorageService.setToken(response.token)
                        request.addValue(
                            response.token,
                            forHTTPHeaderField: "Authorization"
                        )
                        self.executeRequest(request, completion: completion)
                    case .failure:
                        completion(.failure(APIError.invalidToken))
                    }
                }
            }
        }
        else {
            executeRequest(request, completion: completion)
        }
    }

    func refreshAccessToken(
        _ completion: @escaping (Result<TokenResponse, APIError>)
            -> Void
    ) {
        let request = TokenRequest(
            password: AppConfig.password,
            username: AppConfig.username
        )

        guard let request = createURLRequest(from: TokenAPI
            .token(request: request))
        else {
            completion(.failure(.invalidUrlRequest))
            return
        }

        executeRequest(request, completion: completion)
    }
}
