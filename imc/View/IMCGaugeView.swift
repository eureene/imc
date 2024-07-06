//
//  BMIGaugeView.swift
//  imc
//
//  Created by Mohamet amine Ndiaye on 31/01/2024.
//

import SwiftUI

// Vue SwiftUI représentant une jauge pour visualiser l'IMC (Indice de Masse Corporelle).
struct IMCGaugeView: View {
   // var bmi: Double
    let minBmi = 16.0
    let maxBmi = 40.0
    // Propriétés pour la gestion de l'affichage de l'IMC
    @Binding var animatedBMI: Double

    // Calcul du pourcentage de l'IMC par rapport aux valeurs min et max définies
    private var bmiPercentage: Double {
        return (animatedBMI - minBmi) / (maxBmi - minBmi)
    }

    // Composition de la vue, incluant la forme de jauge et le texte pour l'IMC
    var body: some View {

        ZStack {
            GaugeShape()
                .stroke(lineWidth: 20)
                .opacity(0.3)
                .foregroundColor(Color.gray)
            
            GaugeShape()
                .trim(from: 0, to: CGFloat(bmiPercentage))
                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .foregroundColor(colorForBMI(animatedBMI))

            
            Text(String(format: "%.1f", animatedBMI))
                .font(.title2)
                .fontWeight(.bold)
        }
        .aspectRatio(2, contentMode: .fit)
        .padding(40)
    }
    
    // Détermine la couleur de la jauge en fonction de la valeur de l'IMC
    func colorForBMI(_ bmi: Double) -> Color {
        switch bmi {
        case ..<18.5:
            return Color.blue
        case 18.5..<25.0:
            return Color.green
        case 25.0..<30.0:
            return Color.yellow
        case 30.0...:
            return Color.red
        default:
            return Color.gray
        }
    }
}
