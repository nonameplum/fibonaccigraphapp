//
// Algorithms
// Copyright © Łukasz Śliwiński
//  

import Foundation

struct Tree<A: Identifiable> {
  var value: A
  var children: [Tree<A>] = []
  init(_ value: A, children: [Tree<A>] = []) {
    self.value = value
    self.children = children
  }
}

extension Tree {
  var allValues: [A] {
    return children.reduce([value]) { partialResult, nextTree in
      return partialResult + nextTree.allValues
    }
  }

  func traverse(visit: (Self) -> Bool) {
    if visit(self) {
      return
    }

    for child in children {
      child.traverse(visit: visit)
    }
  }

  mutating func modify(_ edit: (inout Self) -> Void) {
    edit(&self)

    for idx in children.indices {
      edit(&children[idx])
    }
  }

  func first(where matching: (A) -> Bool) -> Self? {
    var found: Self?

    traverse { node in
      if matching(node.value) {
        found = node
        return true
      }
      return false
    }

    return found
  }
}
