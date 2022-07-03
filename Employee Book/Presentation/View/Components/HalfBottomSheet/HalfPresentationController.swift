//
//  HalfPresentationController.swift
//  Employee Book
//
//  Created by Dimas Putro on 03/07/22.
//

import UIKit

class HalfPresentationController: UIPresentationController {
  var tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()

  override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
    super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissController))
  }

  override var frameOfPresentedViewInContainerView: CGRect {
    guard let bounds = containerView?.bounds else { return .zero }
    return CGRect(x: 0, y: bounds.height / 2, width: bounds.width, height: bounds.height / 2)
  }


  override func containerViewWillLayoutSubviews() {
    super.containerViewWillLayoutSubviews()
  }

  override func containerViewDidLayoutSubviews() {
    super.containerViewDidLayoutSubviews()
    presentedView?.frame = frameOfPresentedViewInContainerView

    containerView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissController)))
  }

  @objc func dismissController(){
    self.presentedViewController.dismiss(animated: true, completion: nil)
  }
}
