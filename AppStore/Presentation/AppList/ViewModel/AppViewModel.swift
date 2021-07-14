//
//  AppViewModel.swift
//  AppStore
//
//  Created by 장용범 on 2021/07/10.
//

import Foundation
import RxSwift

struct AppViewModel {
    let appModel: AppModel
    private let service: ArtworkServiceProtocol
    
    init(appModel: AppModel, service: ArtworkServiceProtocol) {
        self.appModel = appModel
        self.service = service
    }
    
    func fetchArtworkImage(_ urlString: String) -> Observable<UIImage> {
        service.fetchArtworkImage(urlString)
    }
}
