//
//  User.swift
//  Employee Book
//
//  Created by Dimas Putro on 03/07/22.
//

struct User: Codable {
  let id: Int
  let email: String
  let firstName: String
  let lastName: String
  let avatar: String
  let website: String?
  let annotation: Annotation?

  enum CodingKeys: String, CodingKey {
    case id, email
    case firstName = "first_name"
    case lastName = "last_name"
    case avatar, website, annotation
  }
}

struct Annotation: Codable {
  let latitude: Double
  let longitude: Double

  init(_ latitude: Double, _ longitude: Double) {
    self.latitude = latitude
    self.longitude = longitude
  }
}

