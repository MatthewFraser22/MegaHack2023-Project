//
//  LoginView.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-15.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var isLoggedin: Bool = false
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var authViewModel: AuthViewModel
    @EnvironmentObject private var locationManager: LocationManager

    var body: some View {
        NavigationView {
            VStack {
                topBar

                Text("Login!")
                    .foregroundColor(.backgroundColor)
                    .font(.system(size: 32, weight: .bold, design: .default))

                CustomAuthTextField(placeholder: "To get started enter your email", isSecureTxtField: false, text: $email)
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
            Button {
                if !email.isEmpty, !password.isEmpty {
                    FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { result, error in
                        guard error == nil else {
                            print(error?.localizedDescription)
                            return
                        }

                        authViewModel.login(email: email, password: password) { result in
                            switch result {
                            case .success(let success):
                                self.isLoggedin = true
                                storeUserDataToFirestore()
                            case .failure(let failure):
                                #warning("present error")
                            }
                        }
                        
                    }
                }
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

            NavigationLink(
                destination: MainView()
                    .environmentObject(authViewModel)
                    .environmentObject(locationManager)
                    .toolbar(.hidden),
                isActive: $isLoggedin
            ) { EmptyView() }
        }.padding()
    }
    
    private func storeUserDataToFirestore() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }

        let userData = ["email" : email, "uid" : uid]
        FirebaseManager.shared.firestore.collection("users")
            .document(uid)
            .setData(userData) { error in
                if let err = error {
                    print(err)
                    return
                }
            }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
