//
//  UIView+RoundCornor.swift
//  CuboExam
//
//  Created by Stan Liu on 2018/8/2.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import UIKit

extension UIView {
  
  func roundCorner(radius: CGFloat) {
    self.layer.cornerRadius = radius
    self.layer.masksToBounds = radius > 0
  }
}
