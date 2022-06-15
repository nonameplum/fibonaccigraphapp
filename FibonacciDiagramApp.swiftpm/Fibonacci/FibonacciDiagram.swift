//
// Algorithms
// Copyright © Łukasz Śliwiński
//

import SwiftUI

struct FibonacciDiagram: View {
  @State var tree = Self.makeFibTree(for: fibonacci(4))
  @State var number = 4

  var body: some View {
    GeometryReader { proxy in
      VStack {
        Menu {
          Picker("", selection: $number) {
            ForEach(0 ... 6) { value in
              Text("\(value)")
                .tag(value)
            }
          }
        } label: {
          Text("Fibonacci (\(number))")
            .frame(maxWidth: .infinity)
            .font(.system(.title, design: .serif))
        }
        .padding(.top)

        ScrollView([.vertical, .horizontal]) {
          Diagram(tree: tree, node: { value in
            Text("\(value)")
              .font(.system(.body, design: .monospaced))
              .roundedCircle()
          })
          .frame(maxWidth: proxy.size.width)
        }
      }
    }
    .onChange(of: number) { newValue in
      withAnimation(.linear.delay(0.2)) {
        tree = Self.makeFibTree(for: fibonacci(newValue))
      }
    }
  }

  private static func makeFibTree(for n: Int) -> Tree<Int> {
    if n < 2 {
      return Tree(n)
    }
    return Tree(n, children: [makeFibTree(for: n - 1), makeFibTree(for: n - 2)])
  }
}
