import SwiftUI

struct Card: Identifiable, Equatable {
    let id = UUID()
    let index: Int
    let color: Color

    static func == (lhs: Card, rhs: Card) -> Bool {
        lhs.id == rhs.id
    }
}
