//
//  RoundedCornersShape.swift
//  PiOS
//
//  Created by David Zirath on 2022-11-25.
//

import Foundation
import SwiftUI

struct RoundedCornersShape: Shape {
    
    let corners: UIRectCorner
    let radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

