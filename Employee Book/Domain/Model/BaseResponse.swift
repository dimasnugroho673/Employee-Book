//
//  BaseResponse.swift
//  Employee Book
//
//  Created by Dimas Putro on 03/07/22.
//

struct BaseResponse<T: Codable>: Codable {
  let page: Int
  let perPage: Int
  let total: Int
  let totalPages: Int
  let data: T

  enum CodingKeys: String, CodingKey {
    case page
    case perPage = "per_page"
    case total
    case totalPages = "total_pages"
    case data
  }
}
