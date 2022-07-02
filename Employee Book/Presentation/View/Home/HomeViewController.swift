//
//  HomeViewController.swift
//  Employee Book
//
//  Created by Dimas Putro on 03/07/22.
//

import UIKit

class HomeViewController: UIViewController {

  // MARK: - Properties

  var name: String

  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var nameSelectedLabel: UILabel!
  @IBOutlet var emailSelectedLabel: UILabel!
  @IBOutlet var websiteSelectedLabel: UILabel!
  @IBOutlet var chooseUserButton: UIButton!

  // MARK: - Lifecycle

  init(name: String) {
    self.name = name

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    configureUI()
  }

  // MARK: - Helpers

  private func configureUI() {
    configureNavigationBar()

    title = "Home"

    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleWebsiteLabelTap))
    websiteSelectedLabel.addGestureRecognizer(tapGesture)
    websiteSelectedLabel.isUserInteractionEnabled = true

    nameLabel.text = name
    emailSelectedLabel.isHidden = true
    websiteSelectedLabel.isHidden = true
  }

  // MARK: - Selectors

  @objc func handleWebsiteLabelTap() {
    guard let url = URL(string: "https://suitmedia.com") else { return }

    let vc = WebViewController(url: url)
    navigationController?.pushViewController(vc, animated: true)
  }
}
