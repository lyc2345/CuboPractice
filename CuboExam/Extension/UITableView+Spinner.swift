//
//  UITableView+Spinner.swift
//  CuboExam
//
//  Created by Stan Liu on 2018/8/2.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import UIKit

extension UITableView {

  func addSpinner(indicator: UIActivityIndicatorView) {
    tableFooterView = indicator
  }
  
  func startSpinning() {
    guard let footer = tableFooterView as? UIActivityIndicatorView else {
      return
    }
    footer.startAnimating()
    footer.isHidden = false
  }
  
  func stopSpinning() {
    guard let footer = tableFooterView as? UIActivityIndicatorView else {
      return
    }
    footer.stopAnimating()
    footer.isHidden = true
  }
}
