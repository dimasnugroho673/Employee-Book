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

  // MARK: - Selectors

  @objc func handleNextButtonTap() {
    guard let name = nameTextField.text else { return }

    let nextVC = HomeViewController(name: name)
    navigationController?.pushViewController(nextVC, animated: true)
  }

  // MARK: - Service

  // MARK: - Helpers

  private func configureUI() {
    navigationItem.backButtonTitle = ""

    nextButton.addTarget(self, action: #selector(handleNextButtonTap), for: .touchUpInside)
  }
}

