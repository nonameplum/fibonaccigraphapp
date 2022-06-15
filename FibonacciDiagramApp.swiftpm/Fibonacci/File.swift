//
// Algorithms
// Copyright © Łukasz Śliwiński
//  

import SwiftUI

private struct RoundedCircleStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .frame(width: 25, height: 25)
      .background(Circle().stroke())
      .background(Circle().fill(Color(white: 0.95)))
  }
}

extension View {
  func roundedCircle() -> some View {
    modifier(RoundedCircleStyle())
  }
}
