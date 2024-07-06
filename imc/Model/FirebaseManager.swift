//
//  FirebaseManager.swift
//  imc
//
//  Created by Mohamet amine Ndiaye on 31/01/2024.
//

import Foundation
import FirebaseFirestore

class FirebaseManager {
    static let shared = FirebaseManager() // Instance Singleton
   
    private let db = Firestore.firestore()

    // Stocke un nouvel enregistrement de l'IMC dans la base de données Firestore.
    func storeBMI(name: String, height: Int, weight: Int, bmi: Double) {
        let bmiData: [String: Any] = [
            "imc": bmi,
            "nom": name,
            "taille": height,
            "poids": weight,
            "timestamp": Timestamp(date: Date())
        ]

        db.collection("bmiRecords").addDocument(data: bmiData) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added with ID: \(bmiData)")
            }
        }
    }
    
    // Récupère tous les enregistrements de l'IMC de la base de données Firestore, classés par timestamp en ordre décroissant.
    func fetchBMIRecords(completion: @escaping ([BMIRecord]) -> Void) {
        db.collection("bmiRecords").order(by: "timestamp", descending: true).getDocuments { (querySnapshot, err) in
            var records: [BMIRecord] = []
            if let err = err {
                print("Error getting documents: \(err)")
                completion([])
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let name = data["nom"] as? String ?? "Unknown"
                    let bmi = data["imc"] as? Double ?? 0.0
                    let height = data["taille"] as? Int ?? 0
                    let weight = data["poids"] as? Int ?? 0

                    let record = BMIRecord(name: name, bmi: bmi, height: height, weight: weight)
                    records.append(record)
                }
                completion(records)
            }
        }
    }

}
