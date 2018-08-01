//
//  Timeline.swift
//  CuboExam
//
//  Created by Stan Liu on 2018/8/1.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import Foundation

struct Timeline {
  var title: String = ""
  var date: Date?
  var imageUrls: [String] = []
  
  init(title: String, date: Date?, imageUrls: [String]) {
    self.title = title
    self.date = date
    self.imageUrls = imageUrls
  }
}
