import SwiftUI

struct MoveXYEnd: AnimatableModifier {

  var totalDistanceX: CGFloat
  var totalDistanceY: CGFloat
  var percentage: CGFloat
  var onEnd: () -> () = {}

  private var distanceX: CGFloat { percentage * totalDistanceX }
  private var distanceY: CGFloat { percentage * totalDistanceY }

  var animatableData: CGFloat {
    get { percentage }
    set {
      percentage = newValue
      checkIfFinished()
    }
  }

  func checkIfFinished() -> () {
    if percentage == 1 {
      DispatchQueue.main.async {
        self.onEnd()
      }
    }
  }

  func body(content: Content) -> some View {
    content
    .offset(x: distanceX, y: distanceY)
  }
}
