//
//  ButtonConfig.swift
//  hianime-clone
//
//  Created by apple on 16/08/24.
//

import SwiftUI

enum ButtonType {
    case primary
    case secondary
}

struct RoundedButtonStyle: ButtonStyle {
    var buttonType: ButtonType
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 14))
            .padding(7)
            .background(buttonType == .primary ? Color.red : Color.gray)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}
