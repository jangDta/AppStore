//
//  RecentSearchAppListUseCase.swift
//  AppStore
//
//  Created by a60105114 on 2021/07/15.
//

import Foundation
import RxSwift

protocol RecentSearchAppListUseCaseProtocol {
    func fetch(count: Int) -> Observable<[String]>
}

class RecentSearchAppListUseCase: RecentSearchAppListUseCaseProtocol {
    
    private let repository: RecentSearchAppListRepositoryProtocol
    
    init(repository: RecentSearchAppListRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetch(count: Int) -> Observable<[String]> {
        self.repository.fetch(count: count)
    }
}
