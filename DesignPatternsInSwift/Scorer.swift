//
//  Scorer.swift
//  DesignPatternsInSwift
//
//  Created by James Jongsurasithiwat on 2/19/17.
//  Copyright © 2017 RepublicOfApps, LLC. All rights reserved.
//

import Foundation

protocol Scorer {

  var nextScorer: Scorer? { get set }

  func computeScoreIncrements<S: Sequence>(pastTurnsReversed: S) -> Int where Turn == S.Iterator.Element
}

class MatchScorer: Scorer {

  var nextScorer: Scorer? = nil

  func computeScoreIncrements<S: Sequence>(pastTurnsReversed: S) -> Int where Turn == S.Iterator.Element {
    var scoreIncrement: Int?
    for turn in pastTurnsReversed {
      if scoreIncrement == nil {
        scoreIncrement = turn.matched! ? 1 : -1
        break
      }
    }
    return (scoreIncrement ?? 0) + (nextScorer?.computeScoreIncrements(pastTurnsReversed: pastTurnsReversed) ?? 0)
  }
}

class StreakScorer: Scorer {
  var nextScorer: Scorer? = nil

  func computeScoreIncrements<S : Sequence>(pastTurnsReversed: S) -> Int where Turn == S.Iterator.Element {
    var streakLength = 0
    // Give a bonus for current streak
    for turn in pastTurnsReversed {
      if turn.matched! {
        streakLength += 1
      } else {
        break
      }
    }
    let streakBonus = streakLength >= 5 ? 10 : 0
    // Return my work plus whatever else in the chain gives a score for.
    return streakBonus + (nextScorer?.computeScoreIncrements(pastTurnsReversed: pastTurnsReversed) ?? 0)
  }
}




