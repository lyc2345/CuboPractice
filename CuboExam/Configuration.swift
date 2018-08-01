//
//  Configuration.swift
//  CuboExam
//
//  Created by Stan Liu on 2018/8/1.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import UIKit

enum Configuration {
  
  enum Font {
    static let title = UIFont.systemFont(ofSize: 14)
    static let subTitle = UIFont.systemFont(ofSize: 12)
    
    static let maskNumber = UIFont.systemFont(ofSize: 23)
  }
  
  enum Theme {
    static let black = UIColor.black
    static let gray = UIColor.gray
    static let white = UIColor.white
  }
  
  enum DateFormat {

    static let reverseDateFormatter: DateFormatter = { () -> DateFormatter in
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "mm/dd/yyyy"
      return dateFormatter
    }()
  }
}