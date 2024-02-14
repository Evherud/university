//
//  ContentView.swift
//  tesrswift1
//
//  Created by Eugeny on 20.07.2021.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: tesrswift1Document

    var body: some View {
        TextEditor(text: $document.text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(tesrswift1Document()))
    }
}
