//
//  EditProfileView.swift
//  Hackenschmidt
//
//  Created by Joey Krämer on 17.06.24.
//
import SwiftUI

struct EditProfileView: View {
    @Binding var name: String
    @Binding var weight: String
    @Binding var height: String
    @Binding var sex: String
    @Binding var caloriesIntakeGoal: String
    @Binding var activityLevel: String

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Name", text: $name)
                }

                Section(header: Text("Weight")) {
                    TextField("Weight", text: $weight)
                        .keyboardType(.decimalPad)
                }

                Section(header: Text("Height")) {
                    TextField("Height", text: $height)
                        .keyboardType(.decimalPad)
                }

                Section(header: Text("Sex")) {
                    TextField("Sex", text: $sex)
                }

                Section(header: Text("Calories intake goal")) {
                    TextField("Calories intake goal", text: $caloriesIntakeGoal)
                        .keyboardType(.numberPad)
                }

                Section(header: Text("Activity level")) {
                    TextField("Activity level", text: $activityLevel)
                }
            }
            .navigationBarTitle("Edit Profile", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save") {
                // Handle the save action here
            })
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(name: .constant("Jane"), weight: .constant("60 kg"), height: .constant("175 cm"), sex: .constant("Female"), caloriesIntakeGoal: .constant("2,000 cal"), activityLevel: .constant("Active"))
    }
}
