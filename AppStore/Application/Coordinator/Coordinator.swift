//
//  Coordinator.swift
//  AppStore
//
//  Created by 장용범 on 2021/07/04.
//

import UIKit
import Swinject

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var container: Container { get set }
    var parentCoordinator: Coordinator? { get set }
    
    func start()
    func start(coordinator: Coordinator)
    func didFinish(coordinator: Coordinator)
    func removeChildCoordinators()
}

class BaseCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var container: Container
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController,
         container: Container) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func start() {
        fatalError("Start method must be implemented")
    }
    
    func start(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
    
    func didFinish(coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
    
    func removeChildCoordinators() {
        childCoordinators.forEach { $0.removeChildCoordinators() }
        childCoordinators.removeAll()
    }
}
