//
//  SearchAppListRepositoryProtocol.swift
//  AppStore
//
//  Created by 장용범 on 2021/07/10.
//

import Foundation
import RxSwift

protocol SearchAppListRepositoryProtocol {
    func search(text: String) -> Observable<[AppModel]>
}
