//
//  NewMessageView.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-15.
//

import SwiftUI

class CreateNewMessageViewModel: ObservableObject {
    @Published var users = [ChatUser]()
    @Published var errorMessage = ""

    init() {
        fetchAllUsers()
    }

    private func fetchAllUsers() {
        FirebaseManager.shared.firestore.collection("users")
            .getDocuments { snapshot, error in
                if let error = error {
                    self.errorMessage = "failed to fetch users: \(error)"
                    print("failed to fetch users: \(error)")
                }
                
                snapshot?.documents.forEach({ snapshot in
                    let data = snapshot.data()

                    self.users.append(.init(data: data))
                })
            }
    }
}

struct NewMessageView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var vm = CreateNewMessageViewModel()

    let didSelectNewUser: (ChatUser) -> ()

    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                Text(vm.errorMessage)

                ForEach(vm.users) { user in
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                        didSelectNewUser(user)
                    } label: {
                        HStack(spacing: 16) {
                            Image(systemName: "person.fill")
                                .foregroundColor(.backgroundColor)
                                .font(.system(size: 20))
                                .padding()
                                .overlay {
                                    RoundedRectangle(cornerRadius: 44)
                                        .stroke(Color.backgroundColor, lineWidth: 1)
                                }
                            Text(user.email)
                                .foregroundColor(.primary)
                            
                            Spacer()
                        }.padding(.horizontal)
                        
                        Divider()
                            .padding(.vertical, 8)
                    }

                }
            }
            .navigationTitle("New Message")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                    }

                }
            }
        }
    }
}

//struct NewMessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        // NewMessageView()
//    }
//}
