//
//  GaugeShape.swift
//  imc
//
//  Created by Mohamet amine Ndiaye on 31/01/2024.
//

import SwiftUI

// Structure définissant une forme de jauge personnalisée pour une vue SwiftUI.
struct GaugeShape: Shape {
    
    // Crée le chemin de la forme de la jauge basée sur le rectangle donné.
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.maxY),
                    radius: rect.width / 2,
                    startAngle: Angle(degrees: 180),
                    endAngle: Angle(degrees: 0),
                    clockwise: false)
        return path
    }
}
