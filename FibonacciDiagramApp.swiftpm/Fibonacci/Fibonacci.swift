//
// Algorithms
// Copyright © Łukasz Śliwiński
//

func fibonacci(_ n: Int) -> Int {
  func fibMemo(_ n: Int, memo: inout [Int: Int]) -> Int {
    if let value = memo[n] {
      return value
    }

    if n <= 0 {
      return 0
    }

    if n <= 2 {
      return 1
    }

    let value = fibMemo(n - 1, memo: &memo) + fibMemo(n - 2, memo: &memo)
    memo[n] = value
    return value
  }

  var memo: [Int: Int] = [:]
  return fibMemo(n, memo: &memo)
}
