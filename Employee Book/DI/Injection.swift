//
//  Injection.swift
//  Employee Book
//
//  Created by Dimas Putro on 03/07/22.
//

class Injection {
  func provideUser() -> UserService {
    let remoteDataSource = UserRemoteDataSource()
    let repo = UserRepositoryImplementation(remoteDataSource: remoteDataSource)

    return UserService(userRepository: repo)
  }

  func provideLogin() -> PalindromeService {
    return PalindromeService()
  }
}
