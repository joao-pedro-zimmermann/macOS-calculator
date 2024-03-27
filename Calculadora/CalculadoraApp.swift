//
//  CalculadoraApp.swift
//  Calculadora
//
//  Created by João Pedro Zimmermann on 03/01/24.
//

import SwiftUI

@main
struct CalculadoraApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(width: 200, height: 310)
        }
        .windowResizability(.contentSize)
    }
}
