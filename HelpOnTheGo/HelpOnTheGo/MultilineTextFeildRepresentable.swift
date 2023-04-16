//
//  MultilineTextFeildRepresentable.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-16.
//

import Foundation

import Foundation
import SwiftUI
import UIKit

struct MultilineTextFeildRepresentable: UIViewRepresentable {
    @Binding var text: String

    func makeUIView(context: Context) -> some UITextView {
        let textView = UITextView()
        textView.allowsEditingTextAttributes = true
        textView.isEditable = true
        textView.text = text
        textView.font = .systemFont(ofSize: 20)
        textView.textColor = .blue
        textView.backgroundColor = .systemGray6
        textView.isScrollEnabled = true
        textView.delegate = context.coordinator
        return textView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: MultilineTextFeildRepresentable

        init(parent: MultilineTextFeildRepresentable) {
            self.parent = parent
        }

        func textViewDidBeginEditing(_ textView: UITextView) {
            textView.text = ""
            textView.textColor = .black
        }

        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
        }
    }
}
