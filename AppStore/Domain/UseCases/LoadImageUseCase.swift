//
//  LoadImageUseCase.swift
//  AppStore
//
//  Created by a60105114 on 2021/07/15.
//

import Foundation
import RxSwift

protocol LoadImageUseCaseProtocol {
    func load(imageUrl: String) -> Observable<UIImage>
}

class LoadImageUseCase: LoadImageUseCaseProtocol {
    private let repository: LoadImageRepository
    
    init(repository: LoadImageRepository) {
        self.repository = repository
    }
    
    func load(imageUrl: String) -> Observable<UIImage> {
        self.repository.load(imageUrl: imageUrl)
            .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
    }
}
