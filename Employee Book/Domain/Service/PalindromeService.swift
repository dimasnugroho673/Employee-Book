//
//  PalindromeService.swift
//  Employee Book
//
//  Created by Dimas Putro on 03/07/22.
//

class PalindromeService: PalindromeUseCaseProtocol {
  func check(_ string: String) -> Bool {

    let string = Array(string)

    for (index, word) in string.enumerated() {
      if word != string[string.count - index - 1] {
        return false
      }
    }

    return true
  }
}
