//
//  TurnController.swift
//  DesignPatternsInSwift
//
//  Created by James Jongsurasithiwat on 2/19/17.
//  Copyright © 2017 RepublicOfApps, LLC. All rights reserved.
//

import Foundation

class TurnController {
  private let scorer: Scorer
  private let turnStrategy: TurnStrategy
  var currentTurn: Turn?
  var pastTurns: [Turn] = [Turn]()

  init(turnStrategy: TurnStrategy) {
    self.turnStrategy = turnStrategy
    self.scorer = MatchScorer()
    self.scorer.nextScorer = StreakScorer()
  }

  func beginNewTurn() -> (ShapeView, ShapeView) {
    let shapeViews = turnStrategy.makeShapeViewsForNextTurnGivenPastTurns(pastTurns: pastTurns)
    currentTurn = Turn(shapes: [shapeViews.0.shape, shapeViews.1.shape])
    return shapeViews
  }

  func endTurnWithTappedShape(tappedShape: Shape) -> Int {
    currentTurn?.turnCompleteWithTappedShape(tappedShape: tappedShape)
    pastTurns.append(currentTurn!)

    var scoreIncrement = scorer.computeScoreIncrements(pastTurnsReversed: pastTurns.reversed())

    return scoreIncrement
  }

}








