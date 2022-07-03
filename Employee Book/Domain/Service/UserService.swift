//
//  UserService.swift
//  Employee Book
//
//  Created by Dimas Putro on 03/07/22.
//

class UserService: UserUseCaseProtocol {

  private let userRepository: UserRepositoryImplementation

  init(userRepository: UserRepositoryImplementation) {
    self.userRepository = userRepository
  }

  func fetchUsers(page: Int, completion: @escaping(BaseResponse<[User]>) -> ()) {
    userRepository.fetchUser(page: page) { response in
      completion(response)
    }
  }
}
