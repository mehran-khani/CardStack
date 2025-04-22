import SwiftUI

struct ContentView: View {
    @State private var cards: [Card]
    @State private var offset: CGSize = .zero

    private let cardOfsets: CGFloat = -30
    private let swipeThreshold: CGFloat = 150

    init() {
        _cards = State(initialValue: [
            Card(index: 1, color: Color(red: 0.9, green: 0.3, blue: 0.7)),
            Card(index: 2, color: Color(red: 0.3, green: 0.8, blue: 0.9)),
            Card(index: 3, color: Color(red: 0.4, green: 0.9, blue: 0.4)),
            Card(index: 4, color: Color(red: 0.9, green: 0.7, blue: 0.2)),
            Card(index: 5, color: Color(red: 0.9, green: 0.3, blue: 0.3))
        ])
    }

    var body: some View {
        ZStack {
            ForEach(Array(cards.enumerated()), id: \.element.id) { index, card in
                CardView(card: card, position: calculatePosition(for: index), isOnTop: index == 0)
                    .zIndex(index == 0 ? Double(index) : -Double(index))
                    .gesture(index == 0 ? dragGesture : nil)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .animation(.interpolatingSpring(stiffness: 200, damping: 30), value: offset)
        .animation(.easeInOut(duration: 0.4), value: cards)
    }

    private func calculatePosition(for index: Int) -> CGSize {
        if index == 0 {
            return offset
        } else {
            return CGSize(width: 0, height: cardOfsets * CGFloat(index))
        }
    }

    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { gesture in
                offset = gesture.translation
            }
            .onEnded { gesture in
                let horizontalMovement = abs(gesture.translation.width)
                let verticalMovement = abs(gesture.translation.height)

                if horizontalMovement > swipeThreshold || verticalMovement > swipeThreshold {
                    withAnimation(.easeInOut(duration: 0.6)) {
                        if !cards.isEmpty {
                            let topCard = cards.removeFirst()
                            cards.append(topCard)
                        }
                        offset = .zero
                    }
                } else {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                        offset = .zero
                    }
                }
            }
    }
}

#Preview {
    ContentView()
}
