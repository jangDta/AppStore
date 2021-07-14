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
        let searchAppTrigger: Driver<String>
    }
    
    struct Output {
        let title: Driver<String>
        let fetchAppList: Driver<[AppViewModel]>
    }
    
    private let useCase: SearchAppListUseCase
    
    init(useCase: SearchAppListUseCase) {
        self.useCase = useCase
    }
    
    func transform(input: Input) -> Output {
        let title = Driver.just("AppStore")
        
        let fetchAppList = input.searchAppTrigger.flatMapLatest {
            return self.useCase.search(text: $0)
                .asDriverOnErrorJustComplete()
                .map {
                    $0.map { AppViewModel(appModel: $0, service: ArtworkService()) }
                }
        }
        
        return Output(title: title,
                      fetchAppList: fetchAppList)
    }
}
