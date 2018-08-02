//
//  CacheWorker.swift
//  CuboExam
//
//  Created by Stan Liu on 2018/8/2.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import UIKit

class CacheKit: NSObject {
  
  static let `default` = CacheKit()

  lazy var cache: NSCache = { () -> NSCache<AnyObject, AnyObject> in
    let _cache = NSCache<AnyObject, AnyObject>()
    _cache.name = "com.stan.cubo.imageCache"
    _cache.countLimit = 0 // 0 is not limity
    return _cache
  }()

  func cleanCache() {
    cache.removeAllObjects()
  }

  func cachedImage(name: String) -> UIImage? {
    let cachedImage = cache.object(forKey: name as AnyObject) as? UIImage
    return cachedImage
  }
  
  func cache(image: UIImage, name: String) {
    let cost = Int(image.size.width * image.size.height) //* self.count
    self.cache.setObject(image, forKey: name as AnyObject, cost: cost)
  }
}
