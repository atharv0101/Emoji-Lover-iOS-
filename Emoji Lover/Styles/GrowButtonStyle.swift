// GrowButtonStyle.swift
import SwiftUI

struct GrowButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
            .animation(.spring(response: 0.4, dampingFraction: 0.6), value: configuration.isPressed)
    }
}
