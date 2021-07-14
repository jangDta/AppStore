//
//  Coordinator.swift
//  AppStore
//
//  Created by 장용범 on 2021/07/04.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    func start()
}
