//
//  UserViewController.swift
//  Employee Book
//
//  Created by Dimas Putro on 03/07/22.
//

import UIKit

protocol UserViewDelegate: AnyObject {
  func getUser(user: User)
}

class UserViewController: UIViewController {

  @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
