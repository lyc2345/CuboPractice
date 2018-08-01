//
//  ApiResult.swift
//  CuboExam
//
//  Created by Stan Liu on 2018/8/1.
//  Copyright © 2018 Stan Liu. All rights reserved.
//

import Foundation

enum ApiResult<T> {
  case success(timelines: T)
  case failure(error: NetworkRequestError)
}

enum NetworkRequestError: Error {
  case jsonParsingError(key: String)
  case requestFailed(error: Error, statusCode: Int?)
  case unknownError
  case noNetwork
}
