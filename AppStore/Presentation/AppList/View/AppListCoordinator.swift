//
//  AppListCoordinator.swift
//  AppStore
//
//  Created by 장용범 on 2021/07/04.
//

import UIKit

final class AppListCoordinator: BaseCoordinator {
    
    enum Transition {
        case detail(model: AppModel)
    }

    override func start() {
        let vc = AppListViewController(viewModel: AppListViewModel(useCase: SearchAppListUseCase(repository: SearchAppListRepository(service: SearchAppService(), cache: RecentSearchAppCache()))))
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
