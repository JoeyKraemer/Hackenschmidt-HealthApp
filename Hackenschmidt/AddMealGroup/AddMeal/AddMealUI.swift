import SwiftUI

struct AddMealUI: View {
    @State private var isAdding: Bool = false
    @StateObject private var supabasLogic = SupabaseLogic()

    var body: some View {
        NavigationView {
            ZStack {
                Color("NormalBackground").edgesIgnoringSafeArea(.all)

                VStack {
                    VStack {
                        VStack {
                            SearchBar()
                        }

                        VStack {
                            Text("My meals")
                                .foregroundStyle(Color("ButtonColor"))
                                .font(.system(size: 15, weight: .bold))
                        }
                        VStack {
                            if supabasLogic.authViewModel.isLoading {
                                ProgressView("Loading...")
                            } else if let errorMessage = supabasLogic.errorMessage {
                                Text(errorMessage).foregroundColor(.red)
                            } else {
                                List(supabasLogic.foods, id: \.self) { food in
                                    FoodCard(title: food.food_name, subtitle: food.additional, calories: Int(food.calories))
                                        .listRowBackground(Color.clear)
                                        .foregroundColor(.black)
                                        
                                }
                                .listStyle(PlainListStyle())
                            }
                        }
                        .onAppear {
                            Task {
                                await supabasLogic.fetchFoods()
                            }
                        }
                    }
                    .blur(radius: isAdding ? 5 : 0)
                    .animation(.default, value: isAdding)

                    Spacer()

                    HStack {
                        Spacer()

                        VStack {
                            if isAdding {
                                Button(action: {}) {
                                    VStack {
                                        Image(systemName: "pencil.circle.fill")
                                            .font(.system(size: 50))
                                            .foregroundColor(.purple)
                                        Text("Manual")
                                            .foregroundColor(.black)
                                    }
                                }
                                .padding(.bottom, 10)

                                Button(action: {}) {
                                    VStack {
                                        Image(systemName: "camera.circle.fill")
                                            .font(.system(size: 50))
                                            .foregroundColor(.purple)
                                        Text("Camera")
                                            .foregroundColor(.black)
                                    }
                                }
                                .padding(.bottom, 10)
                            }

                            Button(action: {
                                withAnimation {
                                    self.isAdding.toggle()
                                }
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 60))
                                    .foregroundColor(.purple)
                            }
                            .padding(.bottom, 30)
                        }
                        .padding(.trailing, 20)
                    }
                }
            }
        }
    }
}

// Preview for the SwiftUI view
#Preview {
    AddMealUI()
}
