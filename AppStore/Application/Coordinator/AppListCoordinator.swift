//
//  AppListCoordinator.swift
//  AppStore
//
//  Created by 장용범 on 2021/07/04.
//

import UIKit

final class AppListCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    func start() {
        let rootViewController = AppListViewController(viewModel: AppListViewModel(useCase: SearchAppListUseCase(repository: SearchAppListRepositoryImpl(service: SearchAppService()))))
        navigationController?.setViewControllers([rootViewController], animated: false)
    }
}
