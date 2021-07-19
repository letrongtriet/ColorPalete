//
//  LocalStorageImpl.swift
//  LocalStorageImpl
//
//  Created by Triet M1 Macbook Pro on 19.7.2021.
//

import Foundation

final class LocalStorageImpl {
    private let userDefaults = UserDefaults.standard
}

extension LocalStorageImpl: LocalStorageInterface {
    func getToken() -> String? {
        if let tokenData = try? Keychain.get(account: UserDefaultsKey.token),
           let value = try? JSONDecoder().decode(String.self, from: tokenData)
        {
            return value
        }
        return nil
    }

    func setToken(_ token: String) {
        if let encoded = try? JSONEncoder().encode(token) {
            try? Keychain.set(value: encoded, account: UserDefaultsKey.token)
        }
    }

    func getStorageId() -> String? {
        userDefaults.string(forKey: UserDefaultsKey.storageId)
    }

    func setStorageId(_ storageId: String) {
        userDefaults.set(storageId, forKey: UserDefaultsKey.storageId)
    }

    func getColors() -> Colors? {
        if let decode = userDefaults.object(forKey: UserDefaultsKey.colors) as? Data,
           let value = try? JSONDecoder().decode(Colors.self, from: decode)
        {
            return value
        }
        return nil
    }

    func setColors(_ colors: Colors) {
        if let encoded = try? JSONEncoder().encode(colors) {
            userDefaults.set(encoded, forKey: UserDefaultsKey.colors)
        }
    }

    func logout() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
        try? Keychain.deleteAll()
    }
}
