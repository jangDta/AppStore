//
//  ImageCache.swift
//  AppStore
//
//  Created by 장용범 on 2021/07/10.
//

import UIKit

class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}
