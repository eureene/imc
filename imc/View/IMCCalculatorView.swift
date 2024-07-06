//
//  BMICalculatorView.swift
//  imc
//
//  Created by Mohamet amine Ndiaye on 31/01/2024.
//

import SwiftUI

// Vue SwiftUI pour le calcul de l'IMC, permettant à l'utilisateur de saisir son nom, sa taille et son poids, et d'afficher son IMC.
struct IMCCalculatorView: View {
    
    // Déclarations d'état pour la gestion des entrées utilisateur et de l'affichage
    @State private var isButtonPressed = false
    @State private var name: String = ""
    @State private var height: Int = 185
    @State private var weight: Int = 72
    @State private var bmi: Double = 21.0
    @State private var animatedBMI: Double = 0
    @State private var showingBottomSheet = false
    @ObservedObject var viewModel = IMCRecordsViewModel()

    // Contenu principal de la vue, incluant un formulaire et une navigation
    var body: some View {
        ZStack {
            NavigationView {
                Form {
                    Section(header: Text("Calcule IMC")) {
                        TextField("Nom", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()

                        Picker("Taille", selection: $height) {
                            ForEach(140...220, id: \.self) { Text("\($0) cm") }
                        }

                        Picker("Poids", selection: $weight) {
                            ForEach(40...200, id: \.self) { Text("\($0) kg") }
                        }
                    }

                    CategoryListView(bmi: animatedBMI)
                    IMCGaugeView(animatedBMI: $animatedBMI)

                    Section {
                        calculateButton
                    }
                }
                .navigationBarTitle("Calculateur IMC", displayMode: .inline)
            }

            floatingActionButton
        }
        .sheet(isPresented: $showingBottomSheet) {
            RecordsListView(records: $viewModel.records)
        }
    }

    // Bouton flottant pour afficher les enregistrements
    var floatingActionButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    viewModel.loadRecords()
                    showingBottomSheet = true
                }) {
                    Image(systemName: "plus")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                .padding(.trailing, 22)
                .padding(.bottom, 16)
                .accessibilityLabel("Show Records")
            }
        }
    }

    // Bouton pour déclencher le calcul de l'IMC
    var calculateButton: some View {
        Button("Calculate") {
            isButtonPressed = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                isButtonPressed = false
                calculateBMI()
            }
        }
        .foregroundColor(.white)
        .padding()
        .background(Color.blue)
        .cornerRadius(12)
        .scaleEffect(isButtonPressed ? 0.9 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: isButtonPressed)
        .font(.title2)
    }
    
    
    // Fonction pour calculer l'IMC basé sur la taille et le poids entrés
    func calculateBMI() {
        let heightInMeters = Double(height) / 100.0
        let result = Double(weight) / (heightInMeters * heightInMeters)
        
        
        animatedBMI = 0

        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            if self.animatedBMI < result {
                
                self.animatedBMI += 0.1
            } else {
                
                self.animatedBMI = result.rounded()
                timer.invalidate()
                storeRecords(name: name, height: height, weight: weight, bmi: animatedBMI.rounded())
            }
        }
    }
}

// Vue SwiftUI affichant une liste d'enregistrements d'IMC.
struct RecordsListView: View {
    @Binding var records: [BMIRecord]
    @Environment(\.presentationMode) var presentationMode

    // Affichage des enregistrements d'IMC dans une vue de liste
    var body: some View {
        NavigationView {
            List(records, id: \.name) { record in
                VStack(alignment: .leading) {
                    Text("Nom: \(record.name)")
                    Text("IMC: \(record.bmi, specifier: "%.1f")")
                    Text("Taille: \(record.height) cm")
                    Text("Poids: \(record.weight) kg")
                }
            }
            .navigationBarTitle("BMI Records", displayMode: .inline)
            .toolbar {
                Button("Fermer") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}
