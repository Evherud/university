//
//  tesrswift1App.swift
//  tesrswift1
//
//  Created by Eugeny on 20.07.2021.
//

import SwiftUI

@main
struct tesrswift1App: App {
    var body: some Scene {
        DocumentGroup(newDocument: tesrswift1Document()) { file in
            ContentView(document: file.$document)
        }
    }
}
