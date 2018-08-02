//
//  UIImageView+Async.swift
//  CuboExam
//
//  Created by Stan Liu on 2018/8/2.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
  
  /// custom async download image then cache it
  func downloadImage(urlString: String,
                     key: String,
                     completion: ((UIImage?) -> Void)? = nil) {

    // use cache first
    if let image = CacheKit.default.cachedImage(name: key) {
      DispatchQueue.main.async {
        self.image = image
        completion?(image)
      }
      return
    }
    
    // if cache nil, fetch it
    guard let url = URL(string: urlString) else { return }
    URLSession.shared.dataTask(
      with: url,
      completionHandler: { (data, response, error) -> Void in
      
        DispatchQueue.main.async {
          
          if error != nil {
            completion?(nil)
            return
          }
          let image = UIImage(data: data!)
          self.image = image
          // if there is image, cache it
          if let strongImage = image {
            CacheKit.default.cache(image: strongImage, name: key)
          }
          completion?(image)
        }
    }).resume()
  }
}
