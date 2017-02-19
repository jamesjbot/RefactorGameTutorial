//
//  Turn.swift
//  DesignPatternsInSwift
//
//  Created by James Jongsurasithiwat on 2/19/17.
//  Copyright © 2017 RepublicOfApps, LLC. All rights reserved.
//

import Foundation

class Turn {

  let shapes: [Shape]
  var matched: Bool?

  init(shapes: [Shape]) {
    self.shapes = shapes
  }

  func turnCompleteWithTappedShape(tappedShape: Shape) {
    var maxArea = shapes.reduce(0) { $0 > $1.area ? $0 : $1.area }
    matched = tappedShape.area >= maxArea
  }

}
