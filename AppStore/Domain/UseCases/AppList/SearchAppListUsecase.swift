//
//  SearchAppListUsecase.swift
//  AppStore
//
//  Created by 장용범 on 2021/07/10.
//

import Foundation
import RxSwift

class SearchAppListUseCase {
    private let repository: SearchAppListRepository
    
    init(repository: SearchAppListRepository) {
        self.repository = repository
    }
    
    func search(text: String) -> Observable<[AppModel]> {
        self.repository.search(text: text)
    }
}
