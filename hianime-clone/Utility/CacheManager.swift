//
//  CacheManager.swift
//  hianime-clone
//
//  Created by apple on 13/08/24.
//

import Foundation

class CacheManager {
    static private var cache = [String: Data]()
    static private var cacheOrder = [String]()
    static private let cacheLimit = 50 * 1024 * 1024 // 50 MB limit for the cache

    static func setImageCache(_ url: String, image: Data?) {
        guard let image = image else { return }

        // Remove small images if the cache exceeds the limit
        while currentCacheSize() + image.count > cacheLimit {
            if let smallestKey = cacheOrder.min(by: { cache[$0]!.count < cache[$1]!.count }) {
                cache.removeValue(forKey: smallestKey)
                cacheOrder.removeAll { $0 == smallestKey }
            }
        }

        cache[url] = image
        cacheOrder.append(url)
    }

    static func getImageCache(_ url: String) -> Data? {
        if let image = cache[url] {
            // Move accessed image to the end of the cacheOrder to mark it as recently used
            cacheOrder.removeAll { $0 == url }
            cacheOrder.append(url)
            return image
        }
        return nil
    }

    static private func currentCacheSize() -> Int {
        return cache.values.reduce(0) { $0 + $1.count }
    }

    static func clearCache() {
        cache.removeAll()
        cacheOrder.removeAll()
    }
    
    // Call this method during memory warnings
    static func handleMemoryWarning() {
        clearCache()
    }
}

