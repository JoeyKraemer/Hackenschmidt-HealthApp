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
    @State private var isLoggedOut = false
    @State private var name: String = ""
    @State private var weight: Int = 0
    @State private var height: Int = 0
    @State private var sex: String = ""
    @State private var caloriesIntakeGoal: Int = 0
    @State private var activityLevel: String = ""
    @State private var age: Int = 0
    @State private var body_goal: String = ""
    @State private var notificationsEnabled = UserDefaults.standard.bool(forKey: "notifications")

    private let healthStore = HKHealthStore()

    var body: some View {
        NavigationStack{
            ZStack {
                Color("NormalBackground")
                    .edgesIgnoringSafeArea(.all) // Extend background color into the safe area
                
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
                            Text(name)
                                .font(.title)
                                .bold()
                                .foregroundStyle(Color("TextColor"))
                                .onAppear {
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
                    .background(Color("NormalBackground"))
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
                                    .foregroundStyle(Color("TextColor"))
                                Spacer()
                                Text("\(weight)")
                                    .foregroundStyle(Color("TextColor"))
                            }
                            HStack {
                                Text("Height")
                                    .bold()
                                    .foregroundStyle(Color("TextColor"))
                                Spacer()
                                Text(height.description)
                                    .foregroundStyle(Color("TextColor"))
                            }
                            HStack {
                                Text("Sex")
                                    .bold()
                                    .foregroundStyle(Color("TextColor"))
                                Spacer()
                                Text(sex.description)
                                    .foregroundStyle(Color("TextColor"))
                            }
                            HStack {
                                Text("Calories intake goal")
                                    .bold()
                                    .foregroundStyle(Color("TextColor"))
                                Spacer()
                                Text(caloriesIntakeGoal.description)
                                    .foregroundStyle(Color("TextColor"))
                            }
                            HStack {
                                Text("Activity level")
                                    .bold()
                                    .foregroundStyle(Color("TextColor"))
                                Spacer()
                                Text(activityLevel.description)
                                    .foregroundStyle(Color("TextColor"))
                            }
                            HStack {
                                Text("Body Goal")
                                    .bold()
                                    .foregroundStyle(Color("TextColor"))
                                Spacer()
                                Text(body_goal.description)
                                    .foregroundStyle(Color("TextColor"))
                            }
                            HStack {
                                Text("Age")
                                    .bold()
                                    .foregroundStyle(Color("TextColor"))
                                Spacer()
                                Text(age.description)
                                    .foregroundStyle(Color("TextColor"))
                            }
                            HStack {
                                Text("Notifications")
                                    .bold()
                                    .foregroundStyle(Color("TextColor"))
                                Spacer()
                                Text(notificationsEnabled ? "Enabled" : "Disabled")
                                    .foregroundStyle(Color("TextColor"))
                            }
                        }
                    }
                    .padding()
                    .background(Color("NormalBackground"))
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
                    
                    Spacer()
                    
                    Button(action: {
                        Task {
                            await supabasLogic.authViewModel.signOut()
                            isLoggedOut = true
                        }
                    }) {
                        Text("LOGOUT")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.bottom)
                    .navigationDestination(isPresented: $isLoggedOut){
                        ProcessOneView()
                    }
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
