//
//  TimelineCell.swift
//  CuboExam
//
//  Created by Stan Liu on 2018/8/1.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import UIKit
import Kingfisher

class TimelineCell: UITableViewCell, TimelineLayoutKit {

  @IBOutlet weak var timelineTitleView: TimelineTitleView!
  
  // TimelineLayoutKit
  @IBOutlet weak var subContentView: UIView!

  weak var timelineView: TLParentView?
  
  func bind(timeline: Timeline) {
    
    timelineView = bind(timelineType: TimelineType(urls: timeline.imageUrls))
    timelineTitleView.titleLabel.text = timeline.title
    timelineTitleView.subTitleLabel.text = timeline.displayDateString
    
    for (index, urlString) in timeline.imageUrls.enumerated() {
      guard let timelineView = self.timelineView else {
        return
      }
      guard timelineView.imageViews.count > index else {
        let moreNumber = timeline.imageUrls.count - timelineView.imageViews.count
        timelineView.imageViews.last?.mask(count: moreNumber)
        return
      }
      let url = URL(string: urlString)
      timelineView.imageViews[index].kf.setImage(with: url)
    }
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    timelineView?.removeFromSuperview()
    timelineView = nil
  }
}
