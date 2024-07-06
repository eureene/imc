//
//  BMICategory.swift
//  imc
//
//  Created by Mohamet amine Ndiaye on 31/01/2024.
//

import SwiftUI

// Énumération des catégories d'IMC avec leurs plages de valeurs, descriptions et couleurs associées.
enum IMCCategory: CaseIterable {
    case underweight
    case normal
    case overweight
    case classI
    case classII

    // Plage de valeurs pour chaque catégorie d'IMC
    var range: (Double, Double) {
        switch self {
        case .underweight: return (0, 18.4)
        case .normal: return (18.5, 24.9)
        case .overweight: return (25, 29.9)
        case .classI: return (30, 34.9)
        case .classII: return (35, 40)
     
        }
    }
    
    // Description textuelle de chaque catégorie d'IMC
    var description: String {
        switch self {
        case .underweight: return "Poids insuffisant"
        case .normal: return "Poids normal"
        case .overweight: return "Surpoids"
        case .classI: return "Obésité"
        case .classII: return "Obésité extreme"

        }
    }
    
    // Couleur associée à chaque catégorie d'IMC
    var color: Color {
        switch self {
        case .underweight: return .gray
        case .normal: return .green
        case .overweight: return .yellow
        case .classI, .classII: return .red
        }
    }
    
    // Détermine si une valeur d'IMC donnée appartient à la catégorie
    func contains(bmi: Double) -> Bool {
        return range.0 <= bmi && bmi <= range.1
    }
}
