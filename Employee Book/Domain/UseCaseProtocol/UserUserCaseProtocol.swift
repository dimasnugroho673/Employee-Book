//
//  UserUserCaseProtocol.swift
//  Employee Book
//
//  Created by Dimas Putro on 03/07/22.
//

protocol UserUseCaseProtocol {
  func fetchUsers(page: Int, completion: @escaping(BaseResponse<[User]>) -> ())
}
