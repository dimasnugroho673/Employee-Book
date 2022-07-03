//
//  UserViewController.swift
//  Employee Book
//
//  Created by Dimas Putro on 03/07/22.
//

import UIKit
import SDWebImage

// MARK: - UserViewDelegate

protocol UserViewDelegate: AnyObject {
  func popToHomeAndWithUser(user: User)
}

class UserViewController: UIViewController {

  // MARK: - Properties

  let userViewModel: UserViewModel = UserViewModel(userService: Injection().provideUser())

  @IBOutlet var tableView: UITableView!
  var mapView: MapViewController

  private var page: Int = 1

  weak var delegate: UserViewDelegate?
  weak var mapDelegate: MapViewDelegate?

  // MARK: - Lifecycle

  init() {
    self.mapView = MapViewController(users: [])

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.dataSource = self
    tableView.delegate = self
    tableView.refreshControl = UIRefreshControl()
    tableView.refreshControl?.addTarget(self, action: #selector(handlePullToRefresh), for: .valueChanged)
    tableView.register(UserCell.nib(), forCellReuseIdentifier: UserCell.identifier)


    fetchData(page: page)
    configureBinding()
    configureUI()
  }

  // MARK: - Services

  func fetchData(page: Int) {
    userViewModel.getUser(page: page)
  }

  // MARK: - Helpers

  private func configureBinding() {
    userViewModel.users.bind { users in
      print("DEBUG: Total data: \(self.userViewModel.users.value.count)")
      DispatchQueue.main.async {
        self.tableView.reloadData()
        self.mapView = MapViewController(users: users)
      }
    }

    userViewModel.isLoading.bind { isLoading in
      if !isLoading {
        DispatchQueue.main.async {
          self.tableView.refreshControl?.endRefreshing()
          self.tableView.reloadData()
        }
      }
    }
  }

  private func configureUI() {
    title = "Users"

    configureNavigationBar()

    let rigthBarButton = UIBarButtonItem(image: UIImage(systemName: "map.fill"), style: .plain, target: self, action: #selector(changeViewToMap))
    navigationItem.rightBarButtonItem = rigthBarButton
  }

  // MARK: - Selectors

  @objc func handlePullToRefresh() {
    self.page = 1
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      self.userViewModel.clearData()
      self.fetchData(page: self.page)
    }
  }

  @objc func changeViewToMap() {
    let rigthBarButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(changeViewToListUsers))
    navigationItem.rightBarButtonItem = rigthBarButton

    mapView.delegate = self
    view.addSubview(mapView.view)
    addChild(mapView)
    mapView.didMove(toParent: self)
  }

  @objc func changeViewToListUsers() {
    let rigthBarButton = UIBarButtonItem(image: UIImage(systemName: "map.fill"), style: .plain, target: self, action: #selector(changeViewToMap))
    navigationItem.rightBarButtonItem = rigthBarButton

    mapView.view.removeFromSuperview()
    mapView.didMove(toParent: nil)
  }
}

// MARK: - UserViewController: UITableViewDelegate

extension UserViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    delegate?.popToHomeAndWithUser(user: userViewModel.users.value[indexPath.row])
    navigationController?.popViewController(animated: true)
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let position = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height

    if (position > (contentHeight - 100 - scrollView.frame.size.height) && scrollView.isDragging){
      print("DEBUG: Calling reload more \(Date())")
      self.fetchData(page: self.page + 1)
    }
  }
}

// MARK: - UserViewController: UITableViewDataSource

extension UserViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return userViewModel.users.value.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let data = userViewModel.users.value[indexPath.row]

    let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as! UserCell
    cell.profileImage.sd_setImage(with: URL(string: data.avatar))
    cell.nameLabel.text = "\(data.firstName) \(data.lastName) - \(data.id)"
    cell.emailLabel.text = data.email

    return cell
  }
}

// MARK: - UserViewController: MapViewDelegate

extension UserViewController: MapViewDelegate {
  func popToHomeWithUser(user: User) {
    navigationController?.popViewController(animated: true)
    mapDelegate?.popToHomeWithUser(user: user)
  }
}

