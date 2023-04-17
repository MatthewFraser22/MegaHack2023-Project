//
//  CheckmarkView.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-17.
//

import SwiftUI

struct CheckmarkView: View {
    var id: Int
    var text: String
    @Binding var selectedIndex: Int

    var body: some View {
        HStack {
            Image(systemName: self.selectedIndex == id ? "checkmark.square" : "square")
                .resizable()
                .renderingMode(.template)
                .frame(width: 20, height: 20)
                .foregroundColor(.backgroundColor)
            Text(text)
        }
        .onTapGesture {
            selectedIndex = id
        }
    }
}

struct CheckmarkView_Previews: PreviewProvider {
    static var previews: some View {
        CheckmarkView(id: 1, text: "Needs help", selectedIndex: .constant(0))
    }
}
