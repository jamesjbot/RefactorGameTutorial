//
//  GameViewController.swift
//  DesignPatternsInSwift
//
//  Created by Joel Shapiro on 9/23/14.
//  Copyright (c) 2014 RepublicOfApps, LLC. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}


class GameViewController: UIViewController {
  private var turnController: TurnController!
  private var shapeFactory: ShapeFactory!
  private var shapeViewFactory: ShapeViewFactory!
  private var shapeViewBuilder: ShapeViewBuilder!

  override func viewDidLoad() {
    super.viewDidLoad()

    // Initialize the AbstractFactory for ShapeViews in the viewDidLoad
    //shapeViewFactory = SquareShapeViewFactory(size: gameView.sizeAvailableForShapes())
    shapeViewFactory = SquareShapeViewFactory(size: gameView.sizeAvailableForShapes())
    // Initialize the AbstractFactory for Shapes
    shapeFactory = SquareShapeFactory(minProportion: 0.3, maxProportion: 0.8)
    //shapeFactory = SquareShapeFactory(minProportion: 0.3, maxProportion: 0.8)

    shapeViewBuilder = ShapeViewBuilder(shapeViewFactory: shapeViewFactory)
    shapeViewBuilder.fillColor = UIColor.brown
    shapeViewBuilder.outlineColor = UIColor.orange
    turnController = TurnController(shapeFactory: shapeFactory, shapeViewBuilder: shapeViewBuilder)
    beginNextTurn()
  }

  override var prefersStatusBarHidden : Bool {
    return true
  }

  fileprivate func beginNextTurn() {

    let shapeViews = turnController.beginNewTurn()

    shapeViews.0.tapHandler = {
      tappedView in
      self.gameView.score += self.turnController.endTurnWithTappedShape(tappedShape: tappedView.shape)
      self.beginNextTurn()
    }

    shapeViews.1.tapHandler = shapeViews.0.tapHandler

    gameView.addShapeViews(shapeViews)

//    let shapes = shapeFactory.createShapes()
//
//    // Use the builder instead
//    let shapeViews = shapeViewBuilder.buildShapeViewsForShape(shapes: shapes)
//    // Replace shapeview creation code with factory call to create shapeviews
//    //let shapeViews = shapeViewFactory.makeShapeViewsForShapes(shapes: shapes)
//
//    shapeViews.0.tapHandler = {
//      tappedView in
//      self.gameView.score += shapes.0.area >= shapes.1.area ? 1 : -1
//      self.beginNextTurn()
//    }
//    shapeViews.1.tapHandler = {
//      tappedView in
//      self.gameView.score += shapes.1.area >= shapes.0.area ? 1 : -1
//      self.beginNextTurn()
//    }
//
//    gameView.addShapeViews(shapeViews)
  }

  fileprivate var gameView: GameView { return view as! GameView }
}
