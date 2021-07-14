//
//  AppListViewController.swift
//  AppStore
//
//  Created by 장용범 on 2021/07/04.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

class AppListViewController: UIViewController {
    
    // MARK: - Properties
    
    let disposeBag = DisposeBag()
    let viewModel: AppListViewModel
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    // MARK: - Initializer
    
    init(viewModel: AppListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureCollectionView()
        configureSearchController()
        bind()
    }
    
    // MARK: - Functions
    
    func configureUI() {
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func bind() {
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        
        let input = AppListViewModel.Input(title: Driver.merge(viewWillAppear), searchAppTrigger: Driver.just("Happy"))
        
        let output = viewModel.transform(input: input)
        
        print(output)
        
        output.title
            .drive(self.navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        output.fetchAppList
            .drive(self.collectionView.rx.items(cellIdentifier: "AppCollectionViewCell", cellType: AppCollectionViewCell.self)) { collectionView, viewModel, cell in
                cell.viewModel.onNext(viewModel)
            }
            .disposed(by: disposeBag)
    }
    
    private func configureCollectionView() {
        collectionView.register(UINib(nibName: "AppCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AppCollectionViewCell")
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    private func configureSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search Itune"
        searchController.hidesNavigationBarDuringPresentation = false
        

        self.navigationItem.searchController = searchController
    }
}

extension AppListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}
