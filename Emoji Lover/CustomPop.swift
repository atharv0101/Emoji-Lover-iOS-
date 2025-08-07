import SwiftUI

// This ViewModifier will present our custom pop-up
struct CustomPopup<PopupContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let popupContent: () -> PopupContent

    func body(content: Content) -> some View {
        ZStack {
            // The original view content (our TestGamesView)
            content

            // The pop-up and dimmed background
            if isPresented {
                // Dimmed background that can be tapped to dismiss
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isPresented = false
                        }
                    }

                // The content of our pop-up
                popupContent()
                    .background(
                        // Use the system background color to adapt to light/dark mode
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(.systemBackground))
                    )
                    .shadow(color: .black.opacity(0.3), radius: 20)
                    .frame(maxWidth: 400)
                        .fixedSize(horizontal: false, vertical: true)
                    .padding(20) // Keeps the pop-up from touching the screen edges
                    .transition(.scale.combined(with: .opacity))
            }
        }
        .animation(.spring(), value: isPresented)
        .frame(width: 400, height: 800)
    }
}

// An extension to make the modifier easier to use
extension View {
    func customPopup<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        self.modifier(CustomPopup(isPresented: isPresented, popupContent: content))
    }
}
