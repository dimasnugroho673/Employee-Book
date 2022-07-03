//
//  PalindromeService.swift
//  Employee Book
//
//  Created by Dimas Putro on 03/07/22.
//

class PalindromeService: PalindromeUseCaseProtocol {
  func check(_ string: String) -> Bool {

    var oldString = string.lowercased()
    oldString = oldString.replacingOccurrences(of: " ", with: "")

    let string = Array(oldString)

    for (index, word) in string.enumerated() {
      if word != string[string.count - index - 1] {
        return false
      }
    }

    return true
  }
}
