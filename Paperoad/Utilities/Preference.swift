//
//  Preference.swift
//  Paperoad
//
//  Created by Tieming on 1/25/23.
//

import Foundation

extension UserDefaults {
    @objc var preferColorTheme: String {
        get {
            return string(forKey: "preferColorTheme") ?? "System Default"
        }
        set {
            set(newValue, forKey: "preferColorTheme")
        }
    }
    
    @objc var invertColor: Bool {
        get {
            return bool(forKey: "invertColor")
        }
        set {
            set(newValue, forKey: "invertColor")
        }
    }
}

func registerPreference() {
    UserDefaults.standard.register(
        defaults: [
                "appLibraryFolder": FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("paperoad").absoluteString,
                "invertColor": false,
                "preferColorTheme": "System Default",
                
                // scrapper
                "pdfBuiltInScrapper": true,
                "arXivScrapper": true,
                "DOIScrapper": true,
                "IEEEScrapper": true,
                
                // scrapper API key
                "IEEEScrapperAPIKey": ""
            ]
    )
}
