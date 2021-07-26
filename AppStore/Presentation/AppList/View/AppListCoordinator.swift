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
    
    override func start() {
        guard let vc = container.resolve(AppListViewController.self) else {
            return
        }
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func performTransition(to transition: Transition) {
        switch transition {
        case .detail(let model):
            removeChildCoordinators()
            let coordinator = AppDetailCoordinator(navigationController: navigationController, container: container)
            coordinator.showDetail(model: model)
        }
    }
}
