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
    func saveRecentSearch(text: String) -> Single<Bool>
}

final class RecentSearchAppCache {

    private let coreDataStorage: CoreDataStorage
    private let disposeBag = DisposeBag()
    private let maxCacheLimit = 10

    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }
}

extension RecentSearchAppCache: RecentSearchAppCachable {

    func fetchRecentSearch(maxCount: Int) -> Observable<[String]> {
        Observable.create { observer in
            self.coreDataStorage.performBackgroundTask { context in
                do {
                    let request: NSFetchRequest = RecentSearchApp.fetchRequest()
                    request.fetchLimit = maxCount
                    
                    let result = try context.fetch(request).compactMap { $0.text }
                    
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
    
    func saveRecentSearch(text: String) -> Single<Bool> {
        Single.create { single in
            self.coreDataStorage.performBackgroundTask { [weak self] context in
                guard let self = self else { return }
                do {
                    try self.cleanUp(text: text, in: context)
                    let entity = RecentSearchApp(context: context)
                    entity.setValue(text, forKey: "text")
                    
                    try context.save()
                    
                    single(.success(true))
                }
                catch {
                    single(.failure(CoreDataStorageError.saveError(error)))
                }
            }
            return Disposables.create()
        }
    }
}

// MARK: - Private
extension RecentSearchAppCache {

    private func cleanUp(text: String, in context: NSManagedObjectContext) throws {
        let request: NSFetchRequest = RecentSearchApp.fetchRequest()
        var result = try context.fetch(request)

        removeDuplicates(text: text, recentSearchList: &result, in: context)
        remove(limit: maxCacheLimit - 1, recentSearchList: result, in: context)
    }

    private func removeDuplicates(text: String, recentSearchList: inout [RecentSearchApp], in context: NSManagedObjectContext) {
        recentSearchList
            .filter { $0.text == text }
            .forEach { context.delete($0) }
        recentSearchList.removeAll { $0.text == text }
    }

    private func remove(limit: Int, recentSearchList: [RecentSearchApp], in context: NSManagedObjectContext) {
        guard recentSearchList.count > limit else { return }

        recentSearchList.suffix(recentSearchList.count - limit)
            .forEach { context.delete($0) }
    }
}
