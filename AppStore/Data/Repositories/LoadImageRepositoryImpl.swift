//
//  LoadImageRepositoryImpl.swift
//  AppStore
//
//  Created by a60105114 on 2021/07/15.
//

import Foundation
import RxSwift

final class LoadImageRepositoryImpl {
    private let service: ArtworkServiceProtocol
    
    init(service: ArtworkServiceProtocol) {
        self.service = service
    }
}

extension LoadImageRepositoryImpl: LoadImageRepository {
    func load(imageUrl: String) -> Observable<UIImage> {
        if let cachedImage = ImageCache.shared.object(forKey: NSString(string: imageUrl)) {
            return Observable.just(cachedImage)
        } else {
            return self.service.fetchArtworkImage(imageUrl)
        }
    }
}
