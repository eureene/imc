//
//  BMIRecordsViewModel.swift
//  imc
//
//  Created by Mohamet amine Ndiaye on 01/02/2024.
//

import Foundation

// Définit un modèle de vue pour la gestion des enregistrements de l'IMC, observable par l'interface utilisateur.
class IMCRecordsViewModel: ObservableObject {
    @Published var records: [BMIRecord] = []
    
    /// Charge les enregistrements de l'IMC depuis la base de données et met à jour l'interface utilisateur de manière asynchrone.
    func loadRecords() {
        FirebaseManager.shared.fetchBMIRecords { [weak self] records in
            DispatchQueue.main.async {
                self?.records = records
            }
        }
    }
}

/// Stocke les enregistrements de l'IMC dans la base de données Firestore en arrondissant l'IMC.
func storeRecords(name: String, height: Int, weight: Int, bmi: Double) {
    
    FirebaseManager.shared.storeBMI(name: name, height: height, weight: weight, bmi: bmi.rounded())
}

// Structure représentant un enregistrement de l'IMC, contenant le nom, l'IMC, la taille et le poids.
struct BMIRecord {
    var name: String
    var bmi: Double
    var height: Int
    var weight: Int
}

