//
//  RecentSearchAppListRepositoryImpl.swift
//  AppStore
//
//  Created by a60105114 on 2021/07/15.
//

import Foundation
import RxSwift

final class RecentSearchAppListRepositoryImpl {
    
    private let cache: RecentSearchAppCachable
    
    init(cache: RecentSearchAppCachable) {
        self.cache = cache
    }
}

extension RecentSearchAppListRepositoryImpl: RecentSearchAppListRepository {
    func fetch(count: Int) -> Observable<[String]> {
        self.cache.fetchRecentSearch(maxCount: count)
    }
}
