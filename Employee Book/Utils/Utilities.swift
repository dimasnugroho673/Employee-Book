//
//  Utilities.swift
//  Employee Book
//
//  Created by Dimas Putro on 03/07/22.
//

import UIKit

class Utilities {
  static func showDialog(view: UIViewController, title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

    let dismissButton = UIAlertAction(title: "Dismiss", style: .cancel)

    alert.addAction(dismissButton)

    view.present(alert, animated: true)
  }
}
