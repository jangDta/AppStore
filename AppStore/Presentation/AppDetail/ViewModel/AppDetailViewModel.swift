//
//  AppDetailViewModel.swift
//  AppStore
//
//  Created by a60105114 on 2021/07/15.
//

import Foundation

class AppDetailViewModel: ViewModelType {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    let model: AppModel
    
    init(model: AppModel) {
        self.model = model
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
    
}
