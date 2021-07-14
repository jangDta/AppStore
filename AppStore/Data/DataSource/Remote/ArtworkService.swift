//
//  ArtworkService.swift
//  AppStore
//
//  Created by 장용범 on 2021/07/10.
//

import UIKit
import Alamofire
import RxSwift

protocol ArtworkServiceProtocol {
    func fetchArtworkImage(_ urlString: String) -> Observable<UIImage>
}

class ArtworkService: ArtworkServiceProtocol {
    
    func fetchArtworkImage(_ urlString: String) -> Observable<UIImage> {
        return Observable.create { observer -> Disposable in
            
            AF.request(URL(string: urlString)!).responseData { response in
                if let error = response.error {
                    observer.onError(error)
                }
                
                if let image = UIImage(data: response.data!) {
                    observer.onNext(image)
                }
                
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
}
