//
//  WelcomeView.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-15.
//

import SwiftUI

struct WelcomeView: View {
    @State var toggleLoginView: Bool = false
    @State var toggleRegisterView: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundColor

                VStack(alignment: .center, spacing: 2) {
                    helpOnTheGoText
                    Spacer()
                    Image("logo")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                    Spacer(minLength: 0)

                    loginButtons
                    
                    divider

                    alreadyHaveAnAccount
                    
                    Spacer(minLength: 0)
                }
                .padding(.top, 80)
            }
            .ignoresSafeArea(.all)
            .navigationTitle("")
            .toolbar(.hidden)
        }
    }

    private var divider: some View {
        HStack {
            Rectangle()
                .foregroundColor(.white)
                .opacity(0.3)
                .frame(width: UIScreen.main.bounds.width * 0.35, height: 1)

            Text("Or")
                .foregroundColor(.white)

            Rectangle()
                .foregroundColor(.white)
                .opacity(0.3)
                .frame(width: UIScreen.main.bounds.width * 0.35, height: 1)
        }
    }

    private var helpOnTheGoText: some View {
        VStack(alignment: .center, spacing: 8) {
            Text("Help On The Go!")
                .foregroundColor(.white)
                .fontWeight(.heavy)
                .font(.system(size: 40))
            Text("Empowering Connections, Strengthening Communities")
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .fontWeight(.medium)
        }
    }

    private var loginButtons: some View {
        VStack(spacing: 15) {
            AccountButtons(buttonType: .google) {
                print("Signin with google")
            }

            AccountButtons(buttonType: .other) {
                self.toggleRegisterView.toggle()
            }

            NavigationLink(destination: RegisterView().toolbar(.hidden), isActive: $toggleRegisterView) {
                EmptyView()
            }
        }.padding(8)
    }

    private var alreadyHaveAnAccount: some View {
        VStack(spacing: 15) {
            Text("Already have an account ?")
                .foregroundColor(.white)
                .fontWeight(.bold)

            AccountButtons(buttonType: .login) {
                self.toggleLoginView.toggle()
            }
    
            NavigationLink(destination: LoginView().toolbar(.hidden), isActive: $toggleLoginView) {
                EmptyView()
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
