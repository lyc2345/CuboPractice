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
  
  func downloadImage(urlString: String, completion: ((UIImage?) -> Void)? = nil) {
    
    guard let url = URL(string: urlString) else { return }
    URLSession.shared.dataTask(with: url,
                               completionHandler: { (data, response, error) -> Void in
      
      if error != nil {
        completion?(nil)
        return
      }
      DispatchQueue.main.async(execute: { () -> Void in
        let image = UIImage(data: data!)
        self.image = image
        completion?(image)
      })
    }).resume()
  }
  
}
