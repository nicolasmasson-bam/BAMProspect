//
//  FavoriteStore.swift
//  BAMProspect
//
//  Created by Nicolas Masson on 06/09/2020.
//  Copyright © 2020 BAM. All rights reserved.
//

import Foundation
class FavoriteStore {
    static let sharedStore = FavoriteStore()

    func clear() {
        favorites = nil
    }

    fileprivate var _favorites: [Int]?
    var favorites: [Int]? {
        get {
            if let fav = _favorites {
                return fav
            }
            if let data = UserDefaults.standard.object(forKey: StorageType.favorite.rawValue) as? Data {
                return NSKeyedUnarchiver.unarchiveObject(with: data) as? [Int]
            }
            return nil
        }
        set {
            _favorites = newValue
            updateStorage()
        }
    }

    func addFavorite(favoriteId: Int) {
        if favorites == nil {
            favorites = [favoriteId]
        } else {
            favorites?.append(favoriteId)
        }
        updateStorage()
    }

    func removeFavorite(favoriteId: Int) {
        favorites?.removeAll(where: {$0 == favoriteId})
        updateStorage()
    }

    fileprivate func updateStorage() {
        if let fav = favorites {
            let data = NSKeyedArchiver.archivedData(withRootObject: fav)
            UserDefaults.standard.set(data, forKey: StorageType.favorite.rawValue)
        } else {
            UserDefaults.standard.removeObject(forKey: StorageType.favorite.rawValue)
        }
        UserDefaults.standard.synchronize()
    }

    
}

private enum StorageType: String {
    case favorite = "FavoriteStorage"
}
