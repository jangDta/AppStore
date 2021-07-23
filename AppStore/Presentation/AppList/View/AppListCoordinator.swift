//
//  AppListCoordinator.swift
//  AppStore
//
//  Created by 장용범 on 2021/07/04.
//

import UIKit
import Swinject

final class AppListCoordinator: BaseCoordinator {
    
    enum Transition {
        case detail(model: AppModel)
    }
    
    let container = Container() { container in
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

    override func start() {
        guard let vc = container.resolve(UIViewController.self) as? AppListViewController else { return }
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func performTransition(to transition: Transition) {
        switch transition {
        case .detail(let model):
            removeChildCoordinators()
            let coordinator = AppDetailCoordinator(navigationController: navigationController)
            coordinator.showDetail(model: model)
        }
    }
}
