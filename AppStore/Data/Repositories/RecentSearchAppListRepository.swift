//
//  RecentSearchAppListRepository.swift
//  AppStore
//
//  Created by a60105114 on 2021/07/15.
//

import Foundation
import RxSwift

final class RecentSearchAppListRepository {
    
    private let cache: RecentSearchAppCachable
    
    init(cache: RecentSearchAppCachable) {
        self.cache = cache
    }
}

extension RecentSearchAppListRepository: RecentSearchAppListRepositoryProtocol {
    func fetch(count: Int) -> Observable<[String]> {
        self.cache.fetchRecentSearch(maxCount: count)
    }
}
