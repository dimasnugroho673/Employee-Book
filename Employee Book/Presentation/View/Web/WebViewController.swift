//
//  WebViewController.swift
//  Employee Book
//
//  Created by Dimas Putro on 03/07/22.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

  // MARK: - Properties

  var url: URL

  @IBOutlet var webView: WKWebView!

  init(url: URL) {
    self.url = url

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()


    configureUI()

    webView.load(URLRequest(url: url))
  }

  // MARK: - Helpers

  private func configureUI() {
    configureNavigationBar()

    webView.backgroundColor = .white
  }

}
