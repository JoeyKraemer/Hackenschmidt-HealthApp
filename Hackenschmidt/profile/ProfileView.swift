//
//  ProfileView.swift
//  Hackenschmidt
//
//  Created by Joey Krämer on 17.06.24.
//
import HealthKit
import SwiftUI

struct ProfileView: View {
    @StateObject private var supabasLogic = SupabaseLogic()
    @State private var isEditViewPresented = false
    @State private var name: String = ""
    @State private var weight: Int = 0
    @State private var height: Int = 0
    @State private var sex: String = "Female"
    @State private var caloriesIntakeGoal: Int = 0
    @State private var activityLevel: String = "Active"
    @State private var age: Int = 0
    @State private var body_goal: String = ""
    @State private var notificationsEnabled = UserDefaults.standard.bool(forKey: "notifications")

    private let healthStore = HKHealthStore()

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.purple)
                if supabasLogic.user_loading {
                    ProgressView("Loading...")
                } else if let errorMessage = supabasLogic.errorMessage {
                    Text(errorMessage).foregroundColor(.red)
                } else {
                    Text(supabasLogic.user_profiles[0].name)
                        .font(.title)
                        .bold()
                        .onAppear{
                            name = supabasLogic.user_profiles[0].name
                            sex = supabasLogic.user_profiles[0].sex
                            weight = supabasLogic.user_profiles[0].weight
                            height = supabasLogic.user_profiles[0].height
                            caloriesIntakeGoal = supabasLogic.user_profiles[0].calorie_goal
                            activityLevel = supabasLogic.user_profiles[0].activity
                            age = supabasLogic.user_profiles[0].age
                            body_goal = supabasLogic.user_profiles[0].body_goal
                        }
                }
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(10)

            VStack(alignment: .leading, spacing: 15) {
                if supabasLogic.user_loading {
                    ProgressView("Loading...")
                } else if let errorMessage = supabasLogic.errorMessage {
                    Text(errorMessage).foregroundColor(.red)
                } else {
                    HStack {
                        Text("Weight")
                            .bold()
                        Spacer()
                        Text("\(weight)")
                    }
                    HStack {
                        Text("Height")
                            .bold()
                        Spacer()
                        Text(height.description)
                    }
                    HStack {
                        Text("Sex")
                            .bold()
                        Spacer()
                        Text(sex.description)
                    }
                    HStack {
                        Text("Calories intake goal")
                            .bold()
                        Spacer()
                        Text(caloriesIntakeGoal.description)
                    }
                    HStack {
                        Text("Activity level")
                            .bold()
                        Spacer()
                        Text(activityLevel.description)
                    }
                    HStack {
                        Text("Body Goal")
                            .bold()
                        Spacer()
                        Text(body_goal.description)
                    }
                    HStack {
                        Text("Age")
                            .bold()
                        Spacer()
                        Text(age.description)
                    }
                    HStack {
                        Text("Notifications")
                            .bold()
                        Spacer()
                        Text(notificationsEnabled ? "Enabled" : "Disabled")
                    }
                }
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(10)

            Button(action: {
                isEditViewPresented = true
            }) {
                Text("CHANGE DATA")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top)
        }
        .padding()
        .sheet(isPresented: $isEditViewPresented) {
            EditProfileView(name: $name, weight: $weight, height: $height, sex: $sex, caloriesIntakeGoal: $caloriesIntakeGoal, activityLevel: $activityLevel, notificationsEnabled: $notificationsEnabled, age: $age, body_goal: $body_goal, healthStore: healthStore)
        }
        .onAppear {
            requestHealthKitAuthorization()
            Task {
                await supabasLogic.fetchUserProfile()
            }
        }
    }

    private func requestHealthKitAuthorization() {
        let healthKitTypesToRead: Set = [
            HKObjectType.quantityType(forIdentifier: .bodyMass)!,
            HKObjectType.quantityType(forIdentifier: .height)!,
            HKObjectType.characteristicType(forIdentifier: .biologicalSex)!,
            HKObjectType.quantityType(forIdentifier: .dietaryEnergyConsumed)!,
        ]

        let healthKitTypesToWrite: Set = [
            HKObjectType.quantityType(forIdentifier: .bodyMass)!,
            HKObjectType.quantityType(forIdentifier: .height)!,
            HKObjectType.quantityType(forIdentifier: .dietaryEnergyConsumed)!,
        ]

        healthStore.requestAuthorization(toShare: healthKitTypesToWrite, read: healthKitTypesToRead) { success, error in
            if !success {
                print("HealthKit authorization failed: \(String(describing: error))")
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
