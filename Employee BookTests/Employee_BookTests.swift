//
//  Employee_BookTests.swift
//  Employee BookTests
//
//  Created by Dimas Putro on 03/07/22.
//

import XCTest
@testable import Employee_Book

class Employee_BookTests: XCTestCase {

  func palindromeChecker() throws {
    let palindromeService = PalindromeService()

    XCTAssertTrue(palindromeService.check("kasur rusak"))
    XCTAssertTrue(palindromeService.check("step on no pets"))
    XCTAssertTrue(palindromeService.check("put it up"))
    XCTAssertFalse(palindromeService.check("suitmedia"))
  }


}
