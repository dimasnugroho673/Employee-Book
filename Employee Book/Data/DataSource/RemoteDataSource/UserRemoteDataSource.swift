//
//  UserRemoteDataSource.swift
//  Employee Book
//
//  Created by Dimas Putro on 03/07/22.
//

import Foundation

final class UserRemoteDataSource {
  func fetchUser(page: Int, completion: @escaping(BaseResponse<[User]>) -> ()) {
    guard let url = URL(string: "https://reqres.in/api/users?page=\(page)&per_page=10") else { return }

    let task = URLSession.shared.dataTask(with: url) { data, response, error in

      if let error = error {
        print("DEBUG: Error while fetch user data: \(error.localizedDescription)")
      }

      if let data = data {
        do {

          let result = try JSONDecoder().decode(BaseResponse<[User]>.self, from: data)

//          completion(result)
          var temp: [User] = []

          let dummyAnnotation: [Annotation] = [
            Annotation(0.927484, 104.438136),
            Annotation(0.928302, 104.441193),
            Annotation(0.929463, 104.444050),
            Annotation(0.926742, 104.452570),
            Annotation(0.901237, 104.486209),
            Annotation(0.916825, 104.485871),
            Annotation(0.894232, 104.479405),
            Annotation(0.919172, 104.512212),
            Annotation(0.921589, 104.526715),
            Annotation(0.917256, 104.503864),
            Annotation(0.923949, 104.500086),
            Annotation(0.927484, 104.438136),
          ]

          for (index, user) in result.data.enumerated() {
            temp.append(User(id: user.id, email: user.email, firstName: user.firstName, lastName: user.lastName, avatar: user.avatar, website: "https://suitmedia.com/", annotation: dummyAnnotation[index]))
          }

          completion(BaseResponse(page: result.page, perPage: result.perPage, total: result.total, totalPages: result.totalPages, data: temp))

        } catch {
          print("DEBUG: Error while fetch user data: \(error.localizedDescription)")
        }
      }
    }

    task.resume()
  }
}
