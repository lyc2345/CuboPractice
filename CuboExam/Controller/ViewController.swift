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
    return timelines % 10
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureTableView()
    fetchTimelines(pageNumber: 0)
  }

  func configureTableView() {
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  func fetchTimelines(pageNumber: Int) {
    api.fetchTimeline { (result) in
      switch result {
      case .success(timeline: let timelines):
        
      case .failure(error: let error):
        
        switch error {
        case .jsonParsingError(key: let key):
          ()
        case .requestFailed(error: let error, statusCode: let statusCode):
          ()
        case .noNetwork:
          ()
        case .unknownError:
          ()
        }
      }
    }
  }
  
  // MARK: UITableViewDelegate
  
  
  // MARK: UITableViewDataSource
  func numberOfSections(in tableView: UITableView) -> Int { return 1 }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return timelines.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    return UItableviewcel()
  }
}

