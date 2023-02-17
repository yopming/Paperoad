//
//  FileAccess.swift
//  Paperoad
//
//  Created by Tieming Geng on 2/15/23.
//

import Foundation


func saveAccess(url: URL) {
    
}

func getAccess() {
    
}
//
//
//private func handleURLReceivedFromOpenPanel(_ url: URL) throws -> Void {
//    let data = try url.bookmarkData(options: .withSecurityScope, includingResourceValuesForKeys: nil, relativeTo: nil)
//        
//    UserDefaults.standard.set(data, forKey: UserDefaultsKeys.writableUrl)
//        
//    guard url.startAccessingSecurityScopedResource() else {
//            fatalError("Failed starting to access security scoped resource for: \(url.path)")
//    }
//}
//
//func getStoredUrl() throws -> URL {
//    guard let data = UserDefaults.standard.data(forKey: UserDefaultsKeys.writableUrl) else {
//        // no url stored so return a url that can be accessed
//        return try FileManager.default
//            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
//            .appendingPathComponent("someSubfolderOrWhatever")
//    }
//        
//    var isStale = false
//    let newUrl = try URL(resolvingBookmarkData: data,
//                         options: .withSecurityScope,
//                         relativeTo: nil,
//                         bookmarkDataIsStale: &isStale)
//      
//    guard newUrl.startAccessingSecurityScopedResource() else {
//        throw Error("Could not start accessing security scoped resource: \(newUrl.path)")
//    }
//
//    return newUrl
//}
