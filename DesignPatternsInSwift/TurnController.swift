//
//  TurnController.swift
//  DesignPatternsInSwift
//
//  Created by James Jongsurasithiwat on 2/19/17.
//  Copyright © 2017 RepublicOfApps, LLC. All rights reserved.
//

import Foundation

class TurnController {

  private let shapeFactory: ShapeFactory
  private var shapeViewBuilder: ShapeViewBuilder

  var currentTurn: Turn?
  var pastTurns: [Turn] = [Turn]()

  init(shapeFactory: ShapeFactory, shapeViewBuilder: ShapeViewBuilder) {
    self.shapeFactory = shapeFactory
    self.shapeViewBuilder = shapeViewBuilder
  }

  func beginNewTurn() -> (ShapeView, ShapeView) {
    let shapes = shapeFactory.createShapes()
    let shapeViews = shapeViewBuilder.buildShapeViewsForShape(shapes: shapes)
    currentTurn = Turn(shapes: [shapeViews.0.shape, shapeViews.1.shape])
    return shapeViews
  }

  func endTurnWithTappedShape(tappedShape: Shape) -> Int {
    currentTurn!.turnCompleteWithTappedShape(tappedShape: tappedShape)
    pastTurns.append(currentTurn!)

    var scoreIncrement = currentTurn!.matched! ? 1 : -1
    return scoreIncrement
  }


}








