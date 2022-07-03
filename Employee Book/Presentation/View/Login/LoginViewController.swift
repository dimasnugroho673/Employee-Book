//
//  LoginViewController.swift
//  Employee Book
//
//  Created by Dimas Putro on 03/07/22.
//

import UIKit

class LoginViewController: UIViewController {

  // MARK: - Properties

  @IBOutlet var nameTextField: UITextField!
  @IBOutlet var palindromeTextField: UITextField!
  @IBOutlet var palindromeCheckButton: UIButton!
  @IBOutlet var nextButton: UIButton!

  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()


    configureUI()
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
    Utilities.showDialog(view: self, title: "Failed", message: "Not Palindrome")
  }

  // MARK: - Service

  // MARK: - Helpers

  private func configureUI() {
    navigationItem.backButtonTitle = ""

    nextButton.addTarget(self, action: #selector(handleNextButtonTap), for: .touchUpInside)
    palindromeCheckButton.addTarget(self, action: #selector(handlePalindromeCheckTap), for: .touchUpInside)
  }


}

