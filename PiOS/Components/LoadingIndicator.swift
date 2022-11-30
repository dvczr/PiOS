//
//  LoadingIndicator.swift
//  PiOS
//
//  Created by David Zirath on 2022-11-25.
//

import SwiftUI

struct LoadingIndicator: View {
    @State private var isLoading = false
    var isSmall: Bool
 
    var body: some View {
        ZStack(alignment: .center) {
            
            
            if !isSmall {
                Text("Loading…").font(.callout.monospaced().lowercaseSmallCaps())
            }
            Circle()
                .stroke(Color(.systemGray5), lineWidth: 14)
                .frame(width: isSmall ? 66 : 100, height: isSmall ? 66 : 100)
 
            Circle()
                .trim(from: 0, to: 0.2)
                .stroke(Color.green, lineWidth: 7)
                .frame(width: isSmall ? 66 : 100, height: isSmall ? 66 : 100)
                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                .animation(
                    .linear(duration: 0.75)
                    .repeatForever(autoreverses: false), value: isLoading)
                .onAppear() {
                    self.isLoading = true
            }
        }.frame(
            width: UIScreen.main.bounds.width * 0.95,
            height: UIScreen.main.bounds.height * 0.25
        )
    }
}

struct LoadingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicator(isSmall: .random())
    }
}

