//
//  HomeViewController.swift
//  Employee Book
//
//  Created by Dimas Putro on 03/07/22.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {

  // MARK: - Properties

  var name: String
  var userWebsite: URL?

  @IBOutlet var profileImage: UIImageView!
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

  override func viewDidLayoutSubviews() {
    profileImage.layer.masksToBounds = true
    profileImage.clipsToBounds = true
    profileImage.layer.cornerRadius =  profileImage.frame.height / 2
    profileImage.contentMode = .scaleAspectFill

    chooseUserButton.layer.cornerRadius = 12
    chooseUserButton.clipsToBounds = true
  }

  // MARK: - Helpers

  private func configureUI() {
    configureNavigationBar()

    title = "Home"

    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleWebsiteLabelTap))
    websiteSelectedLabel.addGestureRecognizer(tapGesture)
    websiteSelectedLabel.isUserInteractionEnabled = true

    let underline = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
    let underlineAttributeString = NSAttributedString(string: websiteSelectedLabel.text  ?? "", attributes: underline)
    websiteSelectedLabel.attributedText = underlineAttributeString

    nameLabel.text = name
    emailSelectedLabel.isHidden = true
    websiteSelectedLabel.isHidden = true

    chooseUserButton.addTarget(self, action: #selector(handleSelectUserTap), for: .touchUpInside)
  }

  // MARK: - Selectors

  @objc func handleSelectUserTap() {
    let vc = UserViewController()
    vc.delegate = self
    vc.mapDelegate = self
    navigationController?.pushViewController(vc, animated: true)
  }

  @objc func handleWebsiteLabelTap() {
    guard let url = self.userWebsite else { return }

    let vc = WebViewController(url: url)
    navigationController?.pushViewController(vc, animated: true)
  }
}

// MARK: - HomeViewController: UserViewDelegate

extension HomeViewController: UserViewDelegate {
  func popToHomeAndWithUser(user: User) {
    emailSelectedLabel.isHidden = false
    websiteSelectedLabel.isHidden = false

    self.nameSelectedLabel.text = "\(user.lastName) \(user.lastName)"
    self.nameSelectedLabel.textColor = UIColor(named: "color_dark_grey")
    self.profileImage.sd_setImage(with: URL(string: user.avatar))
    self.emailSelectedLabel.text = user.email
    self.userWebsite = URL(string: user.website ?? "")
  }
}

// MARK: - HomeViewController: MapViewDelegate

extension HomeViewController: MapViewDelegate {
  func popToHomeWithUser(user: User) {
    emailSelectedLabel.isHidden = false
    websiteSelectedLabel.isHidden = false

    self.nameSelectedLabel.text = "\(user.lastName) \(user.lastName)"
    self.nameSelectedLabel.textColor = UIColor(named: "color_dark_grey")
    self.profileImage.sd_setImage(with: URL(string: user.avatar))
    self.emailSelectedLabel.text = user.email
    self.userWebsite = URL(string: user.website ?? "")
  }
}
