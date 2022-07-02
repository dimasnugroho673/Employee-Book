//
//  UserCell.swift
//  Employee Book
//
//  Created by Dimas Putro on 03/07/22.
//

import UIKit

class UserCell: UITableViewCell {

  // MARK: - Properties

  static let identifier = "UserCell"

  @IBOutlet var profileImage: UIImageView!
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var emailLabel: UILabel!

  weak var delegate: UserViewDelegate?

  // MARK: - Lifecycle

  override func awakeFromNib() {
    super.awakeFromNib()

    profileImage.layer.cornerRadius = profileImage.frame.width / 2
    profileImage.contentMode = .scaleAspectFill
    profileImage.clipsToBounds = true
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

  // MARK: - Helpers

  static func nib() -> UINib {
    return UINib(nibName: "UserCell", bundle: .main)
  }

}
