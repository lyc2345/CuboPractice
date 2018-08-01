//
//  Timeline.swift
//  CuboExam
//
//  Created by Stan Liu on 2018/8/1.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import Foundation

extension Date {
  
  static func date(from string: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    return dateFormatter.date(from: string)
  }
}

struct Timeline {
  var title: String = ""
  var dateString: String = ""
  var imageUrls: [String] = []
  
  var displayDateString: String {
    guard let date = Date.date(from: self.dateString) else {
      return ""
    }
    return Configuration.DateFormat.reverseDateFormatter.string(from: date)
  }

  init(title: String, dateString: String, imageUrls: [String]) {
    self.title = title
    self.dateString = dateString
    self.imageUrls = imageUrls
  }
}
