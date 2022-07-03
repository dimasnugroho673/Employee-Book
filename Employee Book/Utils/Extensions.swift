//
//  Extensions.swift
//  Employee Book
//
//  Created by Dimas Putro on 03/07/22.
//

import UIKit

extension UIViewController {
  func configureNavigationBar() {
    let navigationBarAppearance = UINavigationBarAppearance()
    navigationBarAppearance.configureWithDefaultBackground()
    navigationBarAppearance.backgroundColor = .white
    navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 0.17, green: 0.39, blue: 0.48, alpha: 1.00), NSAttributedString.Key.font: UIFont(name: "Poppins-SemiBold", size: 18)!]

    navigationItem.standardAppearance = navigationBarAppearance
    navigationItem.compactAppearance = navigationBarAppearance
    navigationItem.scrollEdgeAppearance = navigationBarAppearance

    navigationController?.navigationBar.tintColor = UIColor.tintColor
    navigationItem.backButtonTitle = ""
  }
}

extension UINavigationController {
  func backToViewController(vc: Any) {
    for element in viewControllers as Array {
      if "\(type(of: element)).Type" == "\(type(of: vc))" {
        self.popToViewController(element, animated: true)
        break
      }
    }
  }
}

extension UserViewController {
  func createSpinner() -> UIView {
    let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 100))
    let spinner = UIActivityIndicatorView(style: .medium)
    spinner.center = footerView.center

    footerView.addSubview(spinner)
    spinner.startAnimating()

    return footerView
  }
}
