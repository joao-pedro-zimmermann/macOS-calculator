//
//  Fonts.swift
//  Calculadora
//
//  Created by João Pedro Zimmermann on 08/01/24.
//

import SwiftUI

enum TypefaceOne {
    case regular
    
    func font(size: CGFloat) -> Font {
        switch self {
        case .regular:
            return .custom("BungeeLayers-Regular", size: size)
        }
    }
}
