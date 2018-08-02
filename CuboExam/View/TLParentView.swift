//
//  TLParentView.swift
//  CuboExam
//
//  Created by Stan Liu on 2018/8/1.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

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

class TLParentView: UIView {
  @IBOutlet var imageViews: [UIImageView]!
}

protocol TimelineLayoutKit {
  
  var subContentView: UIView! { get set }
  func bind(timelineType: TimelineType) -> TLParentView?
}

extension TimelineLayoutKit {
  
  func bind(timelineType: TimelineType) -> TLParentView? {
    
    guard let timelineContentView: TLParentView = timelineType.view as? TLParentView else {
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
