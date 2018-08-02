//
//  TLParentView.swift
//  CuboExam
//
//  Created by Stan Liu on 2018/8/1.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import UIKit
import SnapKit

class TimelineParentView: UIView {
  
  @IBOutlet var imageViews: [UIImageView]!
  var handleImageIndex: ((Int) -> Void)?
  
  var tapGestures: [UITapGestureRecognizer] = []

  func setupImageViewInteraction() {
    imageViews.forEach {
      $0.isUserInteractionEnabled = true
      attachTapGesture(on: $0)
    }
  }
  
  private func attachTapGesture(on imageVIew: UIImageView) {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(tap:)))
    imageVIew.addGestureRecognizer(tapGesture)
    self.tapGestures.append(tapGesture)
  }
  
  @objc func handleTap(tap: UITapGestureRecognizer) {
    guard let tappedImageView = tap.view as? UIImageView else {
      return
    }
    guard let index = imageViews.index(where: { $0 == tappedImageView }) else { return }
    let imageView = imageViews[index]
    
    // if imageview has mask pass index + 1 to deal with more photo
    guard imageView.subviews.count > 0 else {
      handleImageIndex?(index)
      return
    }
    handleImageIndex?(index + 1)
  }
}

protocol TimelineLayoutKit {
  
  var subContentView: UIView! { get set }
  func bind(timelineType: TimelineType) -> TimelineParentView?
}

extension TimelineLayoutKit {
  
  func bind(timelineType: TimelineType) -> TimelineParentView? {
    
    guard let timelineContentView: TimelineParentView = timelineType.view as? TimelineParentView else {
      return nil
    }

    timelineContentView.translatesAutoresizingMaskIntoConstraints = false
    subContentView.addSubview(timelineContentView)
    
    timelineContentView.snp.makeConstraints { (make) in
      make.edges.equalTo(subContentView)
    }
    timelineContentView.setContentCompressionResistancePriority(.required, for: .vertical)
    return timelineContentView
  }
  
  func removeTimelineLayout() {
    subContentView.subviews.forEach {
      $0.removeFromSuperview()
    }
  }
}
