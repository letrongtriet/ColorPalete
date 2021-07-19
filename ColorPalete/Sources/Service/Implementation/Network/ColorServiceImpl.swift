//
//  ColorServiceImpl.swift
//  ColorServiceImpl
//
//  Created by Triet M1 Macbook Pro on 19.7.2021.
//

import Foundation

final class ColorServiceImpl: NetworkManager, ColorService {
    func getColors(storageId: String, completion: @escaping (Result<ColorCreationResponse, APIError>) -> Void) {
        refreshAccessTokenIfNeededAndMakeRequest(
            ColorAPI.getColors(storageId: storageId),
            completion: completion
        )
    }

    func deleteStorage(storageId: String, completion: @escaping (Result<Bool, APIError>) -> Void) {
        refreshAccessTokenIfNeededAndMakeRequest(
            ColorAPI.deleteStorage(storageId: storageId),
            completion: completion
        )
    }

    func addColor(request: ColorCreationRequest, storageId: String, completion: @escaping (Result<ColorCreationResponse, APIError>) -> Void) {
        refreshAccessTokenIfNeededAndMakeRequest(
            ColorAPI.addColor(
                request: request,
                storageId: storageId
            ),
            completion: completion
        )
    }

    func createStorage(request: ColorCreationRequest, completion: @escaping (Result<ColorCreationResponse, APIError>) -> Void) {
        refreshAccessTokenIfNeededAndMakeRequest(
            ColorAPI.createStorage(request: request),
            completion: completion
        )
    }
}
