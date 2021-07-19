//
//  ColorService.swift
//  ColorService
//
//  Created by Triet M1 Macbook Pro on 19.7.2021.
//

import Foundation

protocol ColorService {
    func getColors(storageId: String, completion: @escaping (Result<ColorCreationResponse, APIError>) -> Void)
    func deleteStorage(storageId: String, completion: @escaping (Result<Bool, APIError>) -> Void)
    func addColor(request: ColorCreationRequest, storageId: String, completion: @escaping (Result<ColorCreationResponse, APIError>) -> Void)
    func createStorage(request: ColorCreationRequest, completion: @escaping (Result<ColorCreationResponse, APIError>) -> Void)
}
