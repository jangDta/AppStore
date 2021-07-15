//
//  RecentSearchAppListRepository.swift
//  AppStore
//
//  Created by a60105114 on 2021/07/15.
//

import Foundation
import RxSwift

protocol RecentSearchAppListRepository {
    func fetch(count: Int) -> Observable<[String]>
}
