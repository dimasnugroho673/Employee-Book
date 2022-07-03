//
//  Observable.swift
//  Employee Book
//
//  Created by Dimas Putro on 03/07/22.
//

// MARK: For Data Binding

class Observable<T> {

  var value: T {
    didSet {
      listener?(value)
    }
  }

  var listener: ((T) -> ())?

  init(_ value: T) {
    self.value = value
  }

  func bind(_ closure: @escaping(T) -> ()) {
    closure(value)
    listener = closure
  }
}

