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
  
  var currentPages: Int {
    if timelines.count == 0 { return 0 }
    return timelines.count % 10
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureTableView()
    fetchTimelines(pageNumber: 0)
  }

  func configureTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.separatorStyle = .none
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 200
    tableView.register(R.nib.timelineCell(),
                       forCellReuseIdentifier: R.nib.timelineCell.name)
  }
  
  func fetchTimelines(pageNumber: Int) {
    api.fetchTimeline { [weak self] (result) in
      switch result {
      case .success(timelines: let newTimelines):
        
        self?.timelines.append(contentsOf: newTimelines)
        self?.tableView.reloadData()
        
      case .failure(error: let error):
        ()
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
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.timelineCell.name) as? TimelineCell else {
      return UITableViewCell()
    }
    let timeline = timelines[indexPath.row]
    cell.bind(timeline: timeline)
    
    return cell
  }
}

