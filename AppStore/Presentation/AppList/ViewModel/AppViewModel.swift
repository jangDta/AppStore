//
//  AppViewModel.swift
//  AppStore
//
//  Created by 장용범 on 2021/07/10.
//

import Foundation
import RxSwift
import RxCocoa

struct AppViewModel: ViewModelType {
    
    struct Input {
    }
    
    struct Output {
        let title: Driver<String>
        let subtitle: Driver<String>
        let artworkImage: Driver<UIImage>
    }
    
    let model: AppModel
    private let useCase: LoadImageUseCaseProtocol
    
    init(model: AppModel, useCase: LoadImageUseCaseProtocol) {
        self.model = model
        self.useCase = useCase
    }
    
    func transform(input: Input) -> Output {
        let title = Driver.just(model.trackName)
            .compactMap { $0 }
        
        let subtitle = Driver.just(model.artistName)
            .compactMap { $0 }
        
        let artworkImage = Driver.just(model.artwork)
            .compactMap { $0 }
            .flatMapLatest {
                return self.useCase.load(imageUrl: $0)
                    .asDriverOnErrorJustComplete()
            }
        
        return Output(title: title,
                      subtitle: subtitle,
                      artworkImage: artworkImage)
    }
}
