//
//  CreateAccountButtons.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-15.
//

import SwiftUI

enum LoginType: String {
    case google = "google"
    case other = "other"
    case login = "login"
}

struct AccountButtons: View {
    var buttonType: LoginType
    var action: () -> Void?

    var body: some View {
        if buttonType == .google {
            Button {
                action()
            } label: {
                HStack(spacing: -4) {
                    Image("\(buttonType.rawValue)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    
                    Text("Continue with \(buttonType.rawValue.capitalized)")
                        .fontWeight(.bold)
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding()
                }.overlay {
                    RoundedRectangle(cornerRadius: 36)
                        .stroke(Color.black, lineWidth: 1)
                        .opacity(0.3)
                        .frame(width: 320, height: 60, alignment: .center)
                }
            }
        } else if buttonType == .login {
            Button {
                action()
            } label: {
                HStack(spacing: -4) {
                    Text("Login")
                        .fontWeight(.bold)
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding()
                }.overlay {
                    RoundedRectangle(cornerRadius: 36)
                        .stroke(Color.black, lineWidth: 1)
                        .opacity(0.3)
                        .frame(width: 320, height: 60, alignment: .center)
                }
            }
        } else if buttonType == .other {
//            RoundedRectangle(cornerRadius: 36)
//                .stroke(Color.black, lineWidth: 1)
//                .opacity(0.3)
//                .foregroundColor(.white)
//                .frame(width: 320, height: 60, alignment: .center)
//                .overlay {
//                    Text("Create Account")
//                        .fontWeight(.heavy)
//                        .foregroundColor(.white)
//                        .font(.title3)
//                        .padding()
//                }
            Button {
                action()
            } label: {
                HStack(spacing: -4) {
                    Text("Create account")
                        .fontWeight(.bold)
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding()
                }.overlay {
                    RoundedRectangle(cornerRadius: 36)
                        .stroke(Color.black, lineWidth: 1)
                        .opacity(0.3)
                        .frame(width: 320, height: 60, alignment: .center)
                }
            }
        }
    }
}

struct AccountButtons_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.backgroundColor
            AccountButtons(buttonType: .google, action: {
                print("tapped")
            })
        }.ignoresSafeArea(.all)
        
    }
}
