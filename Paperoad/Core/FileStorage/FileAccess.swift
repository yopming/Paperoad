//
//  FileAccess.swift
//  Paperoad
//
//  Created by Tieming Geng on 2/15/23.
//

import Foundation


public func saveBookmarkData(for workDir: URL) {
    do {
        let bookmarkData = try workDir.bookmarkData(
            options: .withSecurityScope,
            includingResourceValuesForKeys: nil,
            relativeTo: nil
        )
        
        // save bookmarkData and string url in AppStorage
        Defaults.shared.storageDir = bookmarkData
        Defaults.shared.storageDirUrl = workDir.path(percentEncoded: true)
    } catch {
        print("Failed to save bookmark data for \(workDir)", error)
    }
}

public func restoreFileAccess(with bookmarkData: Data) -> URL? {
    do {
        var isStale = false
        let url = try URL(
            resolvingBookmarkData: bookmarkData,
            options: .withSecurityScope,
            relativeTo: nil,
            bookmarkDataIsStale: &isStale
        )
        
        if isStale {
            // bookmarks could become stale as the OS changes
            print("Bookmark is stale, need to save a new one.")
            saveBookmarkData(for: url)
        }
        
        return url
    } catch {
        print("Error resolving bookmark: ", error)
        return nil
    }
}
