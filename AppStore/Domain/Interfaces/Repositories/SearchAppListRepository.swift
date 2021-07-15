//
//  SearchAppListRepository.swift
//  AppStore
//
//  Created by 장용범 on 2021/07/10.
//

import Foundation
import RxSwift

protocol SearchAppListRepository {
    func search(text: String) -> Observable<[AppModel]>
}
