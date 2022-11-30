//
//  TextFieldRemoverButton.swift
//  PiOS
//
//  Created by David Zirath on 2022-11-24.
//


import SwiftUI

struct TextFieldRemoverButton: ViewModifier {
    @Binding var searchInput: String
    
    func body(content: Content) -> some View {
        HStack {
            content
            
            if !searchInput.isEmpty {
                Button(
                    action: { withAnimation { self.searchInput = "" } },
                    label: { Image(systemName: "delete.left").animation(.easeInOut(duration: 0.5))
                    }
                )
            }
        }
    }
}
