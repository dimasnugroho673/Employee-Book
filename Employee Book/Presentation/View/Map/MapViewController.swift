//
//  MapViewController.swift
//  Employee Book
//
//  Created by Dimas Putro on 03/07/22.
//

import UIKit
import MapKit

// MARK: - MapViewDelegate

protocol MapViewDelegate: AnyObject {
  func popToHomeWithUser(user: User)
}

class MapViewController: UIViewController {

  // MARK: - Properties

  var users: [User]
  var coordinateActive: CLLocationCoordinate2D?

  @IBOutlet var mapView: MKMapView!

  weak var delegate: MapViewDelegate?

  // MARK: - Lifecycle

  init(users: [User]) {
    self.users = users

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    print("DEBUG: Annotation Count: \(users.count)")

    configureUI()
  }

  // MARK: - Helpers

  private func configureUI() {
    navigationItem.backButtonTitle = ""

    mapView.delegate = self
    mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0.9129554, longitude: 104.4920366), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)

    for user in users {
      annotationGenerator(coordinate: CLLocationCoordinate2D(latitude: user.annotation?.latitude ?? 0.0, longitude: user.annotation?.longitude ?? 0.0))
    }
  }

  private func annotationGenerator(coordinate: CLLocationCoordinate2D) {
    let pin = MKPointAnnotation()
    pin.coordinate = coordinate

    mapView.addAnnotation(pin)
  }

  // Convert CoordinateRegion to MapRect
  private func MKMapRectForCoordinateRegion(region:MKCoordinateRegion) -> MKMapRect {
    let topLeft = CLLocationCoordinate2D(latitude: region.center.latitude + (region.span.latitudeDelta/2), longitude: region.center.longitude - (region.span.longitudeDelta/2))
    let bottomRight = CLLocationCoordinate2D(latitude: region.center.latitude - (region.span.latitudeDelta/2), longitude: region.center.longitude + (region.span.longitudeDelta/2))

    let a = MKMapPoint(topLeft)
    let b = MKMapPoint(bottomRight)

    return MKMapRect(origin: MKMapPoint(x:min(a.x,b.x), y:min(a.y,b.y)), size: MKMapSize(width: abs(a.x-b.x), height: abs(a.y-b.y)))
  }

  private func addingInsetsForVisibilityMap(_ view: MKAnnotationView, _ mapView: MKMapView) {
    let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    let region = MKCoordinateRegion(center: view.annotation?.coordinate ?? CLLocationCoordinate2D(latitude: view.annotation?.coordinate.latitude ?? 0.0, longitude: view.annotation?.coordinate.longitude ?? 0.0), span: span)
    let rect = MKMapRectForCoordinateRegion(region: region)

    // Adjust padding for map here
    let insets = UIEdgeInsets(top: 0, left: 0, bottom: 300, right: 0)
    mapView.setVisibleMapRect(rect, edgePadding: insets, animated: true)
  }
}

// MARK: - MapViewController: MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard !(annotation is MKUserLocation) else { return nil }

    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "CustomAnnotation")

    if annotationView == nil {
      annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "CustomAnnotation")
    } else {
      annotationView?.annotation = annotation
    }

    annotationView?.image = UIImage(named: "ic_pin_point")

    return annotationView
  }

  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    // recenter map relative of annoation tap
    mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: view.annotation?.coordinate.latitude ?? 0.0, longitude: view.annotation?.coordinate.longitude ?? 0.0), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)

    // adding visibility
    addingInsetsForVisibilityMap(view, mapView)

    var userSelected: User? = nil

    for user in self.users {
      if view.annotation?.coordinate.latitude == user.annotation?.latitude && view.annotation?.coordinate.longitude == user.annotation?.longitude {
        userSelected = user
      }
    }

    let vc = BottomSheetView(user: userSelected ?? User(id: 0, email: "", firstName: "", lastName: "", avatar: "", website: "", annotation: nil))
    vc.delegate = self
    vc.modalPresentationStyle = .custom
    vc.transitioningDelegate = self

    mapView.deselectAnnotation(view.annotation, animated: false)

    present(vc, animated: true)
  }

}

// MARK: - MapViewController: UIViewControllerTransitioningDelegate

extension MapViewController: UIViewControllerTransitioningDelegate {
  func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    return HalfPresentationController(presentedViewController: presented, presenting: presentingViewController)
  }
}

// MARK: - MapViewController: BottomSheetDelegate

extension MapViewController: BottomSheetDelegate {
  func dismissAndGetUser(user: User) {
    delegate?.popToHomeWithUser(user: user)
  }
}


