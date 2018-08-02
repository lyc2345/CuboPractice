//
//  Timeline.swift
//  CuboExam
//
//  Created by Stan Liu on 2018/8/1.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import UIKit

struct Timeline {
  var title: String = ""
  var dateString: String = ""
  var imageUrls: [String] = []

  private var _imageKeys: [String] = []
  
  var imageKeys: [String] {
    return _imageKeys
  }

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
    
    let imageKeys = imageUrls.map {
      $0.appendRandom
    }
    self._imageKeys = imageKeys
  }
}

enum TimelineType {
  typealias T = [String]
  case one(T)
  case two(T)
  case three(T)
  case four(T)
  case more(T)
  
  init(urls: [String]) {
    switch urls.count {
    case 1:
      self = .one(urls)
    case 2:
      self = .two(urls)
    case 3:
      self = .three(urls)
    case 4:
      self = .four(urls)
    default:
      self = .more(urls)
    }
  }
  var urls: [String] {
    switch self {
    case .one(let urls):
      return urls
    case .two(let urls):
      return urls
    case .three(let urls):
      return urls
    case .four(let urls):
      return urls
    case .more(let urls):
      return urls
    }
  }
  
  var count: Int {
    return urls.count
  }
  
  var className: String {
    switch self {
    case .more:
      return "Timeline\(5)View"
    default:
      return "Timeline\(count)View"
    }
  }
  
  var view: Any {
    switch self {
    case .one:
      return Timeline1View(frame: CGRect.zero)
    case .two:
      return Timeline2View(frame: CGRect.zero)
    case .three:
      return Timeline3View(frame: CGRect.zero)
    case .four:
      return Timeline4View(frame: CGRect.zero)
    case .more:
      return Timeline5View(frame: CGRect.zero)
    }
  }
}
