//
//  TimelineTitleView.swift
//  CuboExam
//
//  Created by Stan Liu on 2018/8/1.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import UIKit

class TimelineTitleView: UIView {

  @IBOutlet var contentView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subTitleLabel: UILabel!
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    xibInit()
    setup()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    xibInit()
    setup()
  }
  
  func xibInit() {
    Bundle.main.loadNibNamed(String(describing: type(of: self)),
                             owner: self,
                             options: nil)
    contentView.frame = self.bounds
    addSubview(contentView)
    contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
  }
  
  func setup() {
    titleLabel.font = Configuration.Font.title
    titleLabel.textColor = Configuration.Theme.black
    
    subTitleLabel.font = Configuration.Font.subTitle
    subTitleLabel.textColor = Configuration.Theme.gray
  }
}
