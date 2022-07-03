//
//  UserViewModel.swift
//  Employee Book
//
//  Created by Dimas Putro on 03/07/22.
//

class UserViewModel {

  private let userService: UserService

  var isLoading: Observable<Bool> = Observable(false)
  var users: Observable<[User]> = Observable([User]())
  var totalDataFromAPI: Int = 0
  var isFirstTime: Bool = true

  init(userService: UserService) {
    self.userService = userService
  }

  func getUser(page: Int) {
    isLoading.value = true

    if (isFirstTime || (users.value.count < totalDataFromAPI)) {
      userService.fetchUsers(page: page) { response in
        print("DEBUG: CALLING API....")
        self.isFirstTime = false
        self.totalDataFromAPI = response.total

        if self.users.value.count < response.total {
          self.users.value.append(contentsOf: response.data)
        }
        self.isLoading.value = false
      }
    }
  }

  func clearData() {
    self.users.value.removeAll()
  }
}

