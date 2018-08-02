//
//  UIImage+NumberMask.swift
//  CuboExam
//
//  Created by Stan Liu on 2018/8/2.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import UIKit

protocol UIImageNumberMaskKit {
  func mask(count: Int)
  func removeMask()
}

extension UIImageNumberMaskKit where Self: UIImageView {
  
  func mask(count: Int) {
    let blurView = UIView(frame: CGRect.zero)
    blurView.translatesAutoresizingMaskIntoConstraints = false
    blurView.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
    
    let numberLabel = UILabel(frame: CGRect.zero)
    numberLabel.translatesAutoresizingMaskIntoConstraints = false
    numberLabel.font = Configuration.Font.maskNumber
    numberLabel.textColor = Configuration.Theme.white
    numberLabel.text = "+\(count)"
    
    addSubview(blurView)
    blurView.addSubview(numberLabel)
    
    blurView.snp.makeConstraints { (make) in
      make.edges.equalTo(self)
    }
    numberLabel.snp.makeConstraints { (make) in
      make.center.equalTo(blurView)
    }
  }
  
  func removeMask() {
    self.subviews.forEach {
      $0.removeFromSuperview()
    }
  }
}

extension UIImageView: UIImageNumberMaskKit { }
