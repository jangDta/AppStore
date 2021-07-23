//
//  SearchAppService.swift
//  AppStore
//
//  Created by 장용범 on 2021/07/10.
//

import Foundation
import Alamofire
import RxSwift

protocol SearchAppServiceProtocol {
    func fetchApps(_ term: String) -> Observable<[App]>
}

class SearchAppService: SearchAppServiceProtocol {
    
    func fetchApps(_ term: String) -> Observable<[App]> {
        return Observable.create { observer -> Disposable in
            
            self.fetchItunes(term) { (apps, error) in
                if let error = error {
                    observer.onError(error)
                }
                
                if let apps = apps {
                    observer.onNext(apps)
                }
                
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    private func fetchItunes(_ term: String, completion: @escaping ([App]?, Error?) -> Void) {
        guard let url = URL(string: "https://itunes.apple.com/search?entity=software&term=\(term)") else { return }
        
        print("API Request : \(term)")
        AF.request(
            url,
            method: .get,
            parameters: nil,
            encoding: JSONEncoding.default,
            headers: nil,
            interceptor: nil,
            requestModifier: nil)
            .responseDecodable(of: SearchAppResponse.self) { response in
                if let error = response.error {
                    completion(nil, error)
                }
                
                if let apps = response.value?.results {
                    return completion(apps, nil)
                }
            }
    }
}
