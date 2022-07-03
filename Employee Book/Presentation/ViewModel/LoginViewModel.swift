//
//  LoginViewModel.swift
//  Employee Book
//
//  Created by Dimas Putro on 03/07/22.
//

class LoginViewModel {

  private let palindromeService: PalindromeService

  var isPalindrome: Observable<Bool> = Observable(false)
  var palindromeMessage: Observable<String> = Observable("")

  init(palindromeService: PalindromeService) {
    self.palindromeService = palindromeService
  }

  func checkPalindrome(_ string: String) {
    switch palindromeService.check(string) {
    case true:
      palindromeMessage.value = "isPalindrome"
    case false:
      palindromeMessage.value = "not palindrome"
    }
  }

}
