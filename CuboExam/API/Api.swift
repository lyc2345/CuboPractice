//
//  Api.swift
//  CuboExam
//
//  Created by Stan Liu on 2018/8/1.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import Alamofire
import SwiftyJSON

class Api {
  
  let cuboUrlString = "https://5qaeek7sj0.execute-api.us-east-1.amazonaws.com/dev/posts"
  
  lazy var alamofireSession: Alamofire.SessionManager = {
    let _manager = Alamofire.SessionManager.default
    _manager.session.configuration.timeoutIntervalForRequest = 10.0
    _manager.session.configuration.timeoutIntervalForResource = 10.0
    return _manager
  }()
  
  func fetchTimeline(completion: @escaping (ApiResult<[Timeline]>) -> Void) {
    
    alamofireSession.request(cuboUrlString, method: .get).responseJSON { (response) in
      
      if let error = response.error {
        completion(.failure(error: .requestFailed(error: error,
                                                  statusCode: response.response?.statusCode)))
        return
      }
      
      guard let data = response.data else {
        completion(.failure(error: .jsonParsingError(key: "response.data is nil")))
        return
      }
      guard let json = try? JSON(data: data) else {
        completion(.failure(error: .jsonParsingError(key: "response.data to JSON(data:) failed")))
        return
      }
      let timelines = json.arrayValue.map { (dictJson)  -> Timeline in
        let dict = dictJson.dictionaryValue
        let timeline = Timeline(title: dict["title"]?.stringValue ?? "",
                                dateString: dict["date"]?.stringValue ?? "",
                                imageUrls: (dict["images"]?.arrayValue ?? []).map { (url) in
                                  url.stringValue
        })
        return timeline
      }
      completion(.success(timelines: timelines))

    }
  }
}
