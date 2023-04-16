//
//  RegisterView.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-15.
//

import SwiftUI
import Firebase

struct RegisterView: View {
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @Environment(\.presentationMode) var presentationMode
    @State var isAuthenticated: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                topBar

                Text("Welcome!")
                    .foregroundColor(.backgroundColor)
                    .font(.system(size: 32, weight: .bold, design: .default))
                
                CustomAuthTextField(placeholder: "username, name, or fullname", isSecureTxtField: false, text: $username)
                CustomAuthTextField(placeholder: "email", isSecureTxtField: false, text: $email)
                CustomAuthTextField(placeholder: "password", isSecureTxtField: true, text: $password)

                loginButton

                Spacer()
                
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

            Image("logo")
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
                .foregroundColor(.blue)

            Spacer()
        }
        .padding()
    }

    @ViewBuilder private var loginButton: some View {
        VStack {
            Button {
                FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { result, error in
                    guard error == nil else {
                        print(error)
                        return
                    }

                    withAnimation {
                        isAuthenticated = true
                    }
                }
            } label: {
                Capsule()
                    //.stroke(lineWidth: 0.3)
                    .foregroundColor(.backgroundColor)
                    .frame(width: 250, height: 50, alignment: .center)
                    .overlay {
                        Text("Register")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
            }

            NavigationLink(destination: MainView().toolbar(.hidden), isActive: $isAuthenticated) { EmptyView() }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
