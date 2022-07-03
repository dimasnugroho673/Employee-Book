//
//  UserRepositoryProtocol.swift
//  Employee Book
//
//  Created by Dimas Putro on 03/07/22.
//

protocol UserRepositoryProtocol {
  func fetchUser(page: Int, completion: @escaping(BaseResponse<[User]>) -> ())
}
