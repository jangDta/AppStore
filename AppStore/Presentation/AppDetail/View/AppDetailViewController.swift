//
//  AppDetailViewController.swift
//  AppStore
//
//  Created by a60105114 on 2021/07/15.
//

import UIKit

class AppDetailViewController: UIViewController {

    weak var coordinator: AppDetailCoordinator?
    let viewModel: AppDetailViewModel
    
    // MARK: - Initializer
    
    init(viewModel: AppDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}
