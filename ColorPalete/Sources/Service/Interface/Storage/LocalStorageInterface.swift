//
//  LocalStorageInterface.swift
//  LocalStorageInterface
//
//  Created by Triet M1 Macbook Pro on 19.7.2021.
//

import Foundation

protocol LocalStorageInterface {
    func getToken() -> String?
    func setToken(_ token: String)

    func getStorageId() -> String?
    func setStorageId(_ storageId: String)

    func getColors() -> Colors?
    func setColors(_ colors: Colors)

    func logout()
}

