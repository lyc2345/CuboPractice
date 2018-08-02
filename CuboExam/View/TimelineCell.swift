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

  var timelineView: TLParentView?

  func setLayout(timeline: Timeline) {
    if timelineView == nil {
      timelineView = bind(timelineType: TimelineType(urls: timeline.imageUrls))
    }
  }
  
  private func setImages(timelineView: TLParentView, timeline: Timeline) {
    
    for (index, urlString) in timeline.imageUrls.enumerated() {
      
      guard timelineView.imageViews.count > index else {
        let moreNumber = timeline.imageUrls.count - timelineView.imageViews.count
        timelineView.imageViews.last?.mask(count: moreNumber)
        return
      }
      // uncomment this to use kingfisher async UIImageView
      //let url = URL(string: urlString)
      //timelineView.imageViews[index].kf.setImage(with: url,
      //                                           placeholder: nil,
      //                                           options: [],
      //                                           progressBlock: nil) { [weak self] (_, _, _, _) in
      //                                            self?.setNeedsUpdateConstraints()
      //                                            self?.updateConstraintsIfNeeded()
      //}
      //timelineView.imageViews[index].imageFromServerURL(urlString: urlString)
      guard timeline.imageUrls.count == timeline.imageKeys.count else {
        return
      }
      timelineView.imageViews[index].downloadImage(urlString: urlString,
                                                   key: timeline.imageKeys[index]) { [weak self ](_) in
        //self?.setNeedsUpdateConstraints()
        //self?.updateConstraintsIfNeeded()
        self?.setNeedsLayout()
        self?.layoutIfNeeded()
      }
    }
  }
  
  func bind(timeline: Timeline) {
    
    timelineTitleView.titleLabel.text = timeline.title
    timelineTitleView.subTitleLabel.text = timeline.displayDateString + "  count: \(timeline.imageUrls.count)"

    if let timelineView = self.timelineView {
      setImages(timelineView: timelineView, timeline: timeline)
    } else {
      setLayout(timeline: timeline)
      guard let timelineView = self.timelineView else {
        return
      }
      setImages(timelineView: timelineView, timeline: timeline)
    }
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    timelineView?.removeFromSuperview()
    timelineView = nil
  }
}
