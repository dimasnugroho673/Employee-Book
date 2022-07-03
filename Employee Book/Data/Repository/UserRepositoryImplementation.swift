//
//  UserRepositoryImplementation.swift
//  Employee Book
//
//  Created by Dimas Putro on 03/07/22.
//

class UserRepositoryImplementation: UserRepositoryProtocol {
  private let remoteDataSource: UserRemoteDataSource

  init(remoteDataSource: UserRemoteDataSource) {
    self.remoteDataSource = remoteDataSource
  }

  func fetchUser(page: Int, completion: @escaping(BaseResponse<[User]>) -> ()) {
    remoteDataSource.fetchUser(page: page) { response in
      completion(response)
    }
  }
}
