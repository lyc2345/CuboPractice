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
  
  func downloadImage(urlString: String,
                     key: String,
                     completion: ((UIImage?) -> Void)? = nil) {
    
    // set default background color for imageView
    backgroundColor = Configuration.Theme.gray
    
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
      
      if error != nil {
        completion?(nil)
        return
        }
        DispatchQueue.main.async {
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
