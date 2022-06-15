//
// Algorithms
// Copyright © Łukasz Śliwiński
//  

import SwiftUI

struct Line: Shape {
  var from, to: CGPoint

  func path(in rect: CGRect) -> Path {
    Path { p in
      p.move(to: from)
      p.addLine(to: to)
    }
  }
}

extension Line {
  var animatableData: AnimatablePair<CGPoint.AnimatableData, CGPoint.AnimatableData> {
    get { AnimatablePair(from.animatableData, to.animatableData) }
    set { (from.animatableData, to.animatableData) = (newValue.first, newValue.second) }
  }
}
