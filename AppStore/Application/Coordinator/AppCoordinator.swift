//
//  AppCoordinator.swift
//  AppStore
//
//  Created by a60105114 on 2021/07/23.
//

import Foundation
import RxSwift
import Swinject

class AppCoordinator: BaseCoordinator {
    override func start() {
        let coordinator = AppListCoordinator(navigationController: navigationController)
        start(coordinator: coordinator)
    }
}
