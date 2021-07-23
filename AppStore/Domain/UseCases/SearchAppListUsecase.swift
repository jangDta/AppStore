//
//  SearchAppListUsecase.swift
//  AppStore
//
//  Created by 장용범 on 2021/07/10.
//

import Foundation
import RxSwift

protocol SearchAppListUseCaseProtocol {
    func search(text: String) -> Observable<[AppModel]>
}

class SearchAppListUseCase: SearchAppListUseCaseProtocol {
    private let repository: SearchAppListRepositoryProtocol
    
    init(repository: SearchAppListRepositoryProtocol) {
        self.repository = repository
    }
    
    func search(text: String) -> Observable<[AppModel]> {
        self.repository.search(text: text)
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
    }
}
