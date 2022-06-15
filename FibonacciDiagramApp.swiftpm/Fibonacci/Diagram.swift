//
// Algorithms
// Copyright © Łukasz Śliwiński
//

import SwiftUI

struct Diagram<A: Identifiable, V: View>: View {
  let tree: Tree<A>
  let node: (A) -> V

  private typealias Key = CollectDict<A.ID, Anchor<CGPoint>>

  var body: some View {
    VStack(alignment: .center, spacing: 8) {
      node(tree.value)
        .anchorPreference(key: Key.self, value: .center, transform: {
          [tree.value.id: $0]
        })
      HStack(alignment: .top, spacing: 8) {
        ForEach(tree.children, id: \.value.id, content: { child in
          Diagram(tree: child, node: node)
        })
      }
    }.backgroundPreferenceValue(Key.self, { (centers: [A.ID: Anchor<CGPoint>]) in
      GeometryReader { proxy in
        ForEach(tree.children, id: \.value.id, content: { child in
          Line(
            from: proxy[centers[tree.value.id]!],
            to: proxy[centers[child.value.id]!]
          ).stroke()
        })
      }
    })
  }
}

private struct CollectDict<Key: Hashable, Value>: PreferenceKey {
  static var defaultValue: [Key: Value] { [:] }
  static func reduce(value: inout [Key: Value], nextValue: () -> [Key: Value]) {
    value.merge(nextValue(), uniquingKeysWith: { $1 })
  }
}
