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
