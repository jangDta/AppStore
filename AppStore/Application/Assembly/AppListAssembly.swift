//
//  AppListAssembly.swift
//  AppStore
//
//  Created by a60105114 on 2021/07/23.
//

import Foundation
import Swinject

final class AppListAssembly: Assembly {
    func assemble(container: Container) {
        // DataSource
        container.register(SearchAppServiceProtocol.self) { _ in SearchAppService() }
        container.register(RecentSearchAppCachable.self) { _ in RecentSearchAppCache() }
        
        // Repository
        container.register(SearchAppListRepositoryProtocol.self) { r in
            let repository = SearchAppListRepository(service: r.resolve(SearchAppServiceProtocol.self)!, cache: r.resolve(RecentSearchAppCachable.self)!)
            return repository
        }
        
        // UseCase
        container.register(SearchAppListUseCaseProtocol.self) { r in
            let useCase = SearchAppListUseCase(repository: r.resolve(SearchAppListRepositoryProtocol.self)!)
            return useCase
        }
        
        // ViewModel
        container.register(AppListViewModeling.self) { r in
            let viewModel = AppListViewModel(useCase: r.resolve(SearchAppListUseCaseProtocol.self)!)
            
            return viewModel
        }
        
        // ViewController
        container.register(UIViewController.self) { r in
            let viewController = AppListViewController(viewModel: r.resolve(AppListViewModeling.self)!)
            return viewController
        }
    }
}
