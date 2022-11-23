//
//  Image+Smaller.swift
//  DIP
//
//  Created by Frank Chu on 10/8/22.
//

import SwiftUI

extension Image {
    func smaller(width: CGFloat? = 200, isSizeFixed: Bool = true) -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: isSizeFixed ? width : nil)
    }
}
