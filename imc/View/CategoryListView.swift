//
//  CategoryListView.swift
//  imc
//
//  Created by Mohamet amine Ndiaye on 31/01/2024.
//

import SwiftUI

// Vue SwiftUI affichant une liste des catégories d'IMC avec une indication pour la catégorie correspondant à l'IMC actuel.
struct CategoryListView: View {
    var bmi: Double
    
    // Composition de la vue, affichant chaque catégorie et marquant celle correspondante à l'IMC
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(IMCCategory.allCases, id: \.self) { category in
                HStack {
                    Text(category.description)
                        .foregroundColor(category.color)
                    Spacer()
                    
                    if category.contains(bmi: bmi) {
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                    }
                }
                .padding(.vertical, 4)
            }
        }
    }
}
