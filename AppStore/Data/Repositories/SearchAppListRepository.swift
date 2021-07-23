//
//  SearchAppListRepository.swift
//  AppStore
//
//  Created by 장용범 on 2021/07/10.
//

import Foundation
import RxSwift

final class SearchAppListRepository {
    
    private let service: SearchAppServiceProtocol
    private let cache: RecentSearchAppCachable
    private let disposeBag = DisposeBag()
    
    init(service: SearchAppServiceProtocol, cache: RecentSearchAppCachable) {
        self.service = service
        self.cache = cache
    }
}

extension SearchAppListRepository: SearchAppListRepositoryProtocol {
    func search(text: String) -> Observable<[AppModel]> {
        cache.saveRecentSearch(text: text).subscribe().disposed(by: disposeBag)
        
        return service.fetchApps(text)
            .map {
                $0.map { $0.toModel() }
            }
    }
}
