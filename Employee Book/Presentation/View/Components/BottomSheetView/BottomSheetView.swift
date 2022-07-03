//
//  BottomSheetView.swift
//  Employee Book
//
//  Created by Dimas Putro on 03/07/22.
//

import UIKit
import SDWebImage

// MARK: - BottomSheetDelegate

protocol BottomSheetDelegate: AnyObject {
  func dismissAndGetUser(user: User)
}

// MARK: - @objc BottomSheeWillDismisstDelegate

@objc protocol BottomSheeWillDismisstDelegate: AnyObject {
  func deselectAnnotation()
}

class BottomSheetView: UIViewController {

  // MARK: - Properties

  @IBOutlet var profileUserSelectedImage: UIImageView!
  @IBOutlet var nameUserSelectedImage: UILabel!
  @IBOutlet var selectUserSelectedButton: UIButton!

  var user: User

  weak var delegate: BottomSheetDelegate?

  // MARK: - Lifecycle

  init(user: User) {
    self.user = user

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
    profileUserSelectedImage.layer.masksToBounds = true
    profileUserSelectedImage.clipsToBounds = true
    profileUserSelectedImage.layer.cornerRadius =  profileUserSelectedImage.frame.height / 2
    profileUserSelectedImage.contentMode = .scaleAspectFill

    selectUserSelectedButton.layer.cornerRadius = 12
    selectUserSelectedButton.clipsToBounds = true
  }

  // MARK: - Helpers

  private func configureUI() {
    view.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 335)
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOpacity = 0.5
    view.layer.shadowRadius = 20
    view.layer.shadowOffset = CGSize(width: 10, height: 10)
    view.layer.cornerRadius = 16
    view.layer.maskedCorners = [CACornerMask.layerMinXMinYCorner, CACornerMask.layerMaxXMinYCorner]

    profileUserSelectedImage.sd_setImage(with: URL(string: user.avatar))
    nameUserSelectedImage.text = "\(user.firstName) \(user.lastName)"

    selectUserSelectedButton.addTarget(self, action: #selector(handleSelectUserTap), for: .touchUpInside)
  }

  // MARK: - Selectors

  @objc func handleSelectUserTap() {
    dismiss(animated: true)
    delegate?.dismissAndGetUser(user: user)
  }

}
