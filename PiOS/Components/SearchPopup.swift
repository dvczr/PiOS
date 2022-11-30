//
//  SearchPopup.swift
//  PiOS
//
//  Created by David Zirath on 2022-11-24.
//

import SwiftUI

struct SearchPopup: View {
    
    @Binding var searchInput: String
    @Binding var isSearching: Bool
    var body: some View {
        ZStack(
            alignment: .bottom
        ) {
            
            RoundedRectangle(cornerRadius: 4)
                .fill(Color(UIColor.systemFill).opacity(0.25))
//                .fill(Color.gray.opacity(0.13))
                .clipped(antialiased: true)
                .shadow(color: .black, radius: 7)
                                
            VStack(
                alignment: .center
            ) {

                TextField("Search...", text: $searchInput).monospaced()
                    .modifier(TextFieldRemoverButton(searchInput: $searchInput).animation(Animation.easeInOut(duration: 0.5)))
                    .multilineTextAlignment(.leading)
                    .textFieldStyle(.roundedBorder)
                    .padding(5)
                    .foregroundColor(.primary)
            }
        }
        .frame(
            width: UIScreen.main.bounds.width * 0.925,
            height: UIScreen.main.bounds.height * 0.02,
            alignment: .topTrailing
        ) .shadow(color: .black, radius: 7)

    }
}

struct SearchPopup_Previews: PreviewProvider {
    static var previews: some View {
        SearchPopup(searchInput: .constant("Search"), isSearching: .constant(.random())).background(.clear)
    }
}
