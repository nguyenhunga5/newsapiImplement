//
//  ConfigService.swift
//  NewsapiImplement
//
//  Created by Hung Nguyen Thanh on 9/23/19.
//  Copyright © 2019 Hung Nguyen Thanh. All rights reserved.
//

import UIKit
import KeychainSwift

class ConfigService: NSObject {
    enum Key: String {
        case country
        case keyword
        case username
    }
    
    enum Keyword: String {
        case bitcoin, apple, earthquake, animal
        
        static var array: [Keyword] {
            return [.bitcoin, .apple, .earthquake, .animal]
        }
    }
    
    static let shared = ConfigService()
    
    let keychain = KeychainSwift()
    static let supportCountryCode = [
        "ae": "United Arab Emirates", "ar": "Argentina", "at": "Austria", "au": "Australia", "be": "Belgium",
        "bg": "Bulgaria", "br": "Brazil", "ca": "Canada", "ch": "Switzerland", "cn": "China mainland", "co": "Colombia",
        "cu": "Cuba", "cz": "Czechia", "de": "Germany", "eg": "Egypt", "fr": "France", "gb": "United Kingdom", "gr": "Greece",
        "hk": "Hong Kong", "hu": "Hungary", "id": "Indonesia", "ie": "Ireland", "il": "Israel", "in": "India", "it": "Italy",
        "jp": "Japan", "kr": "South Korea", "lt": "Lithuania", "lv": "Latvia", "ma": "Morocco", "mx": "Mexico", "my": "Malaysia",
        "ng": "Nigeria", "nl": "Netherlands", "no": "Norway", "nz": "New Zealand", "ph": "Philippines", "pl": "Poland",
        "pt": "Portugal", "ro": "Romania", "rs": "Serbia", "ru": "Russia", "sa": "Saudi Arabia", "se": "Sweden",
        "sg": "Singapore", "si": "Slovenia", "sk": "Slovakia", "th": "Thailand", "tr": "Turkey",
        "tw": "Taiwan", "ua": "Ukraine", "us": "United States", "ve": "Venezuela", "za": "South Africa",
    ]
    
    override init() {
        super.init()
    }
    
    func store(_ string: String?, for key: Key) {
        if let string = string {
            self.keychain.set(string, forKey: key.rawValue)
        } else {
            self.keychain.delete(key.rawValue)
        }
    }
    
    func stored(for key: Key) -> String? {
        return self.keychain.get(key.rawValue)
    }
    
    func clear() {
        keychain.clear()
    }
    
    func changeCountry(from viewController: UIViewController) {
        let alertController = UIAlertController(title: "Countries",
                                                message: "Choose one country",
                                                preferredStyle: .actionSheet)
        let arr = ConfigService.supportCountryCode
        let selectedCountry = stored(for: .country)
        
        for country in arr {
            alertController.addAction(
                UIAlertAction(title: country.value,
                              style: .default,
                              handler: {[weak self, weak alertController] _ in
                                self?.updateCountry(country.key)
                                alertController?.dismiss(animated: true, completion: nil)
                })
            )
        }
        
        if selectedCountry != nil {
            alertController.addAction(
                UIAlertAction(title: "Cancel",
                              style: .cancel,
                              handler: {[weak alertController] _ in
                                alertController?.dismiss(animated: true, completion: nil)
                })
            )
        }
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    func updateCountry(_ country: String) {
        store(country, for: .country)
        NotificationCenter.default.post(name: .countryChanged, object: nil)
    }
}

extension Notification.Name {
    static let countryChanged = NSNotification.Name(rawValue: "CountryChangedNotification")
}
