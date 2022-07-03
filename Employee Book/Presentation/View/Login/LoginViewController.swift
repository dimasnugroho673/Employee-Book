//
//  LoginViewController.swift
//  Employee Book
//
//  Created by Dimas Putro on 03/07/22.
//

import UIKit

class LoginViewController: UIViewController {

  // MARK: - Properties

  private let loginViewModel: LoginViewModel = LoginViewModel(palindromeService: Injection().provideLogin())

  @IBOutlet var nameTextField: UITextField!
  @IBOutlet var palindromeTextField: UITextField!
  @IBOutlet var palindromeCheckButton: UIButton!
  @IBOutlet var nextButton: UIButton!

  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()


    configureUI()
    configureBinding()
  }

  override func viewDidLayoutSubviews() {
    palindromeCheckButton.layer.cornerRadius = 12
    palindromeCheckButton.clipsToBounds = true

    nextButton.layer.cornerRadius = 12
    nextButton.clipsToBounds = true
  }

  // MARK: - Selectors

  @objc func handleNextButtonTap() {
    guard let name = nameTextField.text else { return }

    let nextVC = HomeViewController(name: name)
    navigationController?.pushViewController(nextVC, animated: true)
  }

  @objc func handlePalindromeCheckTap() {
    guard let rawPalindromeString = palindromeTextField.text else { return }

    loginViewModel.checkPalindrome(rawPalindromeString)
  }
  
  // MARK: - Helpers

  private func configureUI() {
    navigationItem.backButtonTitle = ""

    nextButton.addTarget(self, action: #selector(handleNextButtonTap), for: .touchUpInside)
    palindromeCheckButton.addTarget(self, action: #selector(handlePalindromeCheckTap), for: .touchUpInside)
  }

  private func configureBinding() {
    loginViewModel.palindromeMessage.bind { message in
      if !message.isEmpty {
        Utilities.showDialog(view: self, title: "Palindrome result", message: message)
      }
    }
  }

}

