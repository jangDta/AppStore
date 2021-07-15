//
//  RecentSearchAppCache.swift
//  AppStore
//
//  Created by a60105114 on 2021/07/15.
//


import Foundation
import CoreData
import RxSwift

protocol RecentSearchAppCachable {
    func fetchRecentSearch(maxCount: Int) -> Observable<[String]>
}

final class RecentSearchAppCache {

    private let coreDataStorage: CoreDataStorage
    private let disposeBag = DisposeBag()

    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }
}

extension RecentSearchAppCache: RecentSearchAppCachable {

    func fetchRecentSearch(maxCount: Int) -> Observable<[String]> {
        return Observable.create { observer -> Disposable in
            self.coreDataStorage.performBackgroundTask { context in
                do {
                    let request: NSFetchRequest = RecentSearchApp.fetchRequest()
                    request.fetchLimit = maxCount
                    
                    let result = try context.fetch(request).compactMap { $0.text }
                    
                    print("최근검색어 : -> \(result)")
                    observer.onNext(result)
                }
                catch {
                    observer.onError(CoreDataStorageError.readError(error))
                }
                
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
}
