//
//  HalfPresentationController.swift
//  Employee Book
//
//  Created by Dimas Putro on 03/07/22.
//

import UIKit

class HalfPresentationController: UIPresentationController {

  // MARK: - Properties

  override var frameOfPresentedViewInContainerView: CGRect {
    guard let bounds = containerView?.bounds else { return .zero }
    return CGRect(x: 0, y: (bounds.height / 2) + 80, width: bounds.width, height: (bounds.height / 2) - 80)
  }

  // MARK: - Lifecycle

  override func containerViewDidLayoutSubviews() {
    super.containerViewDidLayoutSubviews()
    presentedView?.frame = frameOfPresentedViewInContainerView

    containerView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissController)))
  }

  // MARK: - Selectors

  @objc func dismissController(){
    self.presentedViewController.dismiss(animated: true, completion: nil)
  }
}
