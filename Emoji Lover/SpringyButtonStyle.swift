//
//  SpringyButtonStyle.swift
//  Emoji Lover
//
//  Created by Atharv Maheshwari on 31/07/25.
//

// SpringyButtonStyle.swift
import SwiftUI

struct SpringyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.5 : 1)
            .animation(.spring(response: 1, dampingFraction: 0.5), value: configuration.isPressed)
    }
}
