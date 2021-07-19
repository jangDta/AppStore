//
//  AppDetailCoordinator.swift
//  AppStore
//
//  Created by a60105114 on 2021/07/19.
//

import UIKit

final class AppDetailCoordinator: BaseCoordinator {
    
    enum Transition {
        case detail
    }

    override func start() {
        fatalError("Start method must be implemented")
    }
    
    func showDetail(model: AppModel) {
        let vc = AppDetailViewController(viewModel: AppDetailViewModel(model: model))
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
