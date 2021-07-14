//
//  SearchAppListRepositoryImpl.swift
//  AppStore
//
//  Created by 장용범 on 2021/07/10.
//

import Foundation
import RxSwift

class SearchAppListRepositoryImpl: SearchAppListRepository {
    
    private let service: SearchAppServiceProtocol
    
    init(service: SearchAppServiceProtocol) {
        self.service = service
    }
    
    func search(text: String) -> Observable<[AppModel]> {
        service.fetchApps(text)
            .map {
                $0.map { $0.toModel() }
            }
    }
}
// Clean Swift -> clean architecture 변형,,,,,     viper 변형 //    clean swift 구조로 가뒀어 그냥 역할을

//view interactor presenter entity router

// android10 clean architecture github   -> google 정의한 클린아키텍처 구조

