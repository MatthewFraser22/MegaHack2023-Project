//
//  LoginTextField.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-15.
//

import SwiftUI

struct CustomAuthTextField: View {
    var placeholder: String
    var isSecureTxtField: Bool
    @Binding var text: String

    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.gray)
                        .fontWeight(.medium)
                }

                if isSecureTxtField {
                    SecureField("", text: $text)
                        .frame(height: 45)
                        .foregroundColor(.backgroundColor)
                } else {
                    TextField("", text: $text)
                        .frame(height: 45)
                        .foregroundColor(.backgroundColor)
                }
            }

            Rectangle()
                .frame(height: 1, alignment: .center)
                .foregroundColor(.backgroundColor)
                .padding(.top, -2)
        }.padding(.horizontal)
    }
}

struct CustomAuthTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomAuthTextField(placeholder: "test", isSecureTxtField: false, text: .constant("test"))
    }
}
