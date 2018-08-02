//
//  Timeline4View.swift
//  CuboExam
//
//  Created by Stan Liu on 2018/8/1.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import UIKit

class Timeline4View: TimelineParentView {

  @IBOutlet var contentView: UIView!

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
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    imageViews.forEach {
      $0.roundCorner(radius: 2)
    }
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
    imageViews.forEach {
      $0.contentMode = .scaleAspectFill
      $0.clipsToBounds = true
    }
    setupImageViewInteraction()
  }
}
