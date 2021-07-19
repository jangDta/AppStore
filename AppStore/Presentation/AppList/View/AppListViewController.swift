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
    weak var coordinator: AppListCoordinator?
    let disposeBag = DisposeBag()
    let viewModel: AppListViewModel
    private var searchText = PublishSubject<String>()
    
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
        guard let searchBar = self.navigationItem.searchController?.searchBar else { return }
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        
        let input = AppListViewModel.Input(title: Driver.merge(viewWillAppear),
                                           searchAppText: searchBar.rx.text
                                            .orEmpty
                                            .filter { !$0.isEmpty }
                                            .distinctUntilChanged()
                                            .asDriverOnErrorJustComplete(),
                                           searchAppTrigger: searchBar.rx.searchButtonClicked
                                            .asDriverOnErrorJustComplete(),
                                           clickAppTrigger: collectionView.rx.modelSelected(AppViewModel.self)
                                            .asDriverOnErrorJustComplete())
        
        let output = viewModel.transform(input: input)
        
        output.title
            .drive(self.navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        output.fetchAppList
            .map {
                $0.map { AppViewModel(model: $0, useCase: LoadImageUseCase(repository: LoadImageRepositoryImpl(service: ArtworkService())))}
            }
            .drive(self.collectionView.rx.items(cellIdentifier: "AppCollectionViewCell", cellType: AppCollectionViewCell.self)) { collectionView, viewModel, cell in
                cell.bind(viewModel: viewModel)
            }
            .disposed(by: disposeBag)
        
        output.fetchAppDetail.subscribe(onNext: { print($0) }).disposed(by: disposeBag)
        
        // 최근 검색어 불러오나
        let usecase = RecentSearchAppListUseCase(repository: RecentSearchAppListRepositoryImpl(cache: RecentSearchAppCache()))

        usecase.fetch(count: 5).subscribe(onNext: { list in
            print("최근검색어: \(list)")
        }).disposed(by: disposeBag)
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
