//
//  AppListReactor.swift
//  AppStore
//
//  Created by a60105114 on 2021/07/26.
//

import Foundation
import ReactorKit

class AppListReactor: Reactor {
    private let useCase: SearchAppListUseCaseProtocol
    
    var initialState = State(title: "", appList: [], isLoading: false)
    
    init(useCase: SearchAppListUseCaseProtocol) {
        self.useCase = useCase
    }
    
    enum Action {
        case viewWillAppear
        case search(app: String)
    }
    
    enum Mutation {
        case title(String)
        case search([AppModel])
    }
    
    struct State {
        var title: String
        var appList: [AppModel]
        var isLoading: Bool
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            case .viewWillAppear:
                return Observable.just(Mutation.title("AppStore"))
            case .search(let app):
                return useCase.search(text: app)
                    .map { Mutation.search($0) }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
            case .title(let text):
                newState.title = text
            case .search(let models):
                newState.appList = models
        }
        
        return newState
    }
    
}
