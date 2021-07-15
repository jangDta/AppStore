//
//  SearchAppListRepositoryImpl.swift
//  AppStore
//
//  Created by 장용범 on 2021/07/10.
//

import Foundation
import RxSwift

final class SearchAppListRepositoryImpl {
    
    private let service: SearchAppServiceProtocol
    
    init(service: SearchAppServiceProtocol) {
        self.service = service
    }
}

extension SearchAppListRepositoryImpl: SearchAppListRepository {
    func search(text: String) -> Observable<[AppModel]> {
        service.fetchApps(text)
            .map {
                $0.map { $0.toModel() }
            }
    }
}
