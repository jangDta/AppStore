//
//  AppListViewModel.swift
//  AppStore
//
//  Created by 장용범 on 2021/07/10.
//

import Foundation
import RxSwift
import RxCocoa

final class AppListViewModel: ViewModelType {
    
    struct Input {
        let title: Driver<Void>
        let searchAppText: Driver<String>
        let searchAppTrigger: Driver<Void>
        let clickAppTrigger: Driver<AppViewModel>
    }
    
    struct Output {
        let title: Driver<String>
        let fetchAppList: Driver<[AppModel]>
        let fetchAppDetail: Observable<AppModel>
    }
    
    private let useCase: SearchAppListUseCaseProtocol
    
    init(useCase: SearchAppListUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func transform(input: Input) -> Output {
        let title = Driver.just("AppStore")
        
        let fetchAppList = input.searchAppTrigger
            .withLatestFrom(input.searchAppText)
            .flatMapLatest {
                return self.useCase.search(text: $0)
                    .asDriverOnErrorJustComplete()
            }
        
        let fetchAppDetail = input.clickAppTrigger
            .asObservable()
            .map {
                $0.model
            }
        
        return Output(title: title,
                      fetchAppList: fetchAppList,
                      fetchAppDetail: fetchAppDetail)
    }
}
