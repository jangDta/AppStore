//
//  RecentSearchAppListRepositoryProtocol.swift
//  AppStore
//
//  Created by a60105114 on 2021/07/15.
//

import Foundation
import RxSwift

protocol RecentSearchAppListRepositoryProtocol {
    func fetch(count: Int) -> Observable<[String]>
}
