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
        let vc = AppDetailViewController(nibName: "AppDetailViewController", bundle: nil)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
