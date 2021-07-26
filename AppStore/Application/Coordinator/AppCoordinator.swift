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
    private var assembler: Assembler!
    
    override func start() {
        assembler = Assembler([AppListAssembly()], container: container)
        
        let coordinator = AppListCoordinator(navigationController: navigationController, container: container)
        start(coordinator: coordinator)
    }
}
