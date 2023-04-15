//
//  LoginView.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-15.
//

import SwiftUI

struct LoginView: View {
    @State var username: String = ""
    @State var password: String = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                topBar
                CustomAuthTextField(placeholder: "To get started enter your username", isSecureTxtField: false, text: $username)
                CustomAuthTextField(placeholder: "password", isSecureTxtField: true, text: $password)
                
                loginButton
                
                Spacer(minLength: 0)
            }
            .navigationTitle("")
            .toolbar(.hidden)
        }
    }

    private var topBar: some View {
        HStack {
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Cancel")
            }
            .padding(.trailing, 105)

            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
                .foregroundColor(.blue)

            Spacer()
        }
        .padding()
    }

    private var loginButton: some View {
        VStack {
            NavigationLink {
                MainView()
            } label: {
                Capsule()
                    .foregroundColor(.backgroundColor)
                    .frame(width: 250, height: 50, alignment: .center)
                    .overlay {
                        Text("Login")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
            }


        }.padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
