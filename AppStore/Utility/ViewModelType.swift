//
//  ViewModelType.swift
//  AppStore
//
//  Created by 장용범 on 2021/07/10.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
