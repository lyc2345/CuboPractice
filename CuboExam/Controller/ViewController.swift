//
//  ViewController.swift
//  CuboExam
//
//  Created by Stan Liu on 2018/8/1.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var tableView: UITableView!
  
  var api: Api = Api()
  
  var timelines: [Timeline] = []
  
  lazy var indicatorView: UIActivityIndicatorView = {
    let _indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    _indicatorView.frame = CGRect(x: 0,
                                  y: 0,
                                  width: tableView.bounds.width,
                                  height: 44)
    return _indicatorView
  }()
  
  var first: Bool = true
  
  var currentPages: Int {
    if timelines.count == 0 { return 0 }
    return timelines.count
  }
  
  // MARK: ViewController life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureTableView()
    fetchTimelines(pageNumber: 0) { }
  }

  // MARK: Config

  func configureTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.separatorStyle = .none
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 300
    tableView.allowsSelection = false
    tableView.register(R.nib.timelineCell(),
                       forCellReuseIdentifier: R.nib.timelineCell.name)
    
    tableView.addSpinner(indicator: indicatorView)
  }
  
  // MARK: API
  
  func fetchTimelines(pageNumber: Int, completion: (() -> Void)?) {
    api.fetchTimeline { [weak self] (result) in
      
      switch result {
      case .success(timelines: let newTimelines):
        
        //self?.timelines.append(contentsOf: newTimelines){
        if self?.first == true {
          self?.timelines = (self?.timelines ?? []) + newTimelines // Array(newTimelines[0..<3])
          self?.tableView.reloadData()
          completion?()
          self?.first = false
        } else {
          guard newTimelines.count > 0 else {
            completion?()
            return
          }
          self?.timelines = (self?.timelines ?? []) + newTimelines // Array(newTimelines[0..<3])
          self?.tableView.reloadData()
          completion?()
        }

      // to handle request error
      case .failure(error: _):
        completion?()
        //switch error {
        //case .jsonParsingError(key: let key):
        //case .requestFailed(error: let error, statusCode: let statusCode):
        //case .noNetwork:
        //case .unknownError:
        //}
      }
    }
  }
  
  // MARK: UITableViewDelegate
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }

  // MARK: UITableViewDataSource
  
  func numberOfSections(in tableView: UITableView) -> Int { return 1 }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return timelines.count
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
    // pre set layout
    if let cell = cell as? TimelineCell {
      let timeline = timelines[indexPath.row]
      cell.setLayout(timeline: timeline)
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.timelineCell.name) as? TimelineCell else {
      return UITableViewCell()
    }
    let timeline = timelines[indexPath.row]
    cell.bind(timeline: timeline)
    
    // fix: first loaded page cells titleLabel, subTitleLabel be cut or disappear.
    // force to make cell layout again
    if #available(iOS 10.0, *) {
      cell.layoutIfNeeded()
    } else {
      cell.layoutSubviews()
    }

    // index 5 means more than 5 photos
    cell.timelineView?.handleImageIndex = { (index) in
      print("did tap index: \(index)")
    }
    
    return cell
  }
}

extension ViewController {
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    let offset = scrollView.contentOffset.y
    let absoluteBottom = scrollView.contentSize.height - scrollView.frame.size.height
    
    if (absoluteBottom - offset <= 10) {
      // if scroll to bottom, fetch more
      tableView.startSpinning()
      fetchTimelines(pageNumber: currentPages) { [weak self] in
        self?.tableView.stopSpinning()
      }
    }
  }
}

