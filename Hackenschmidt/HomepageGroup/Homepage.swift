import SwiftUI
import UIKit

struct Homepage: View {
    @State private var isAdding: Bool = false

    var body: some View {
        TabView {
            ZStack {
                Color(UIColor.systemPurple).opacity(0.1).edgesIgnoringSafeArea(.all)

                VStack {
                    VStack {
                        HStack {
                            Text("Calories")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.purple)
                                .padding(.top)
                            Spacer()
                        }
                        .padding(.horizontal)

                        Spacer()
                    }
                    .frame(height: 200)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    .padding()
                    .blur(radius: isAdding ? 10 : 0)
                    .animation(.default, value: isAdding)

                    VStack {
                        HStack {
                            Text("Workouts")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.purple)
                                .padding(.top)
                            Spacer()
                        }
                        .padding(.horizontal)

                        Spacer()
                    }
                    .frame(height: 200)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    .padding()
                    .blur(radius: isAdding ? 10 : 0)
                    .animation(.default, value: isAdding)

                    Spacer()

                    HStack {
                        Spacer()

                        VStack {
                            if isAdding {
                                Button(action: {}) {
                                    Image(systemName: "fork.knife.circle.fill")
                                        .font(.system(size: 50))
                                        .foregroundColor(.purple)
                                }
                                .padding(.bottom, 10)

                                Button(action: {}) {
                                    Image(systemName: "trophy.circle.fill")
                                        .font(.system(size: 50))
                                        .foregroundColor(.purple)
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
            .tabItem {
                VStack {
                    Image(systemName: "house.fill")
                        .font(.system(size: 45))
                    Text("Home")
                        .font(.caption)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.purple)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.purple, lineWidth: 2)
                )
                .cornerRadius(10)
                .padding(.horizontal, 5)
            }

            AddMealUI()
                .tabItem {
                    VStack {
                        Image(systemName: "book.circle.fill")
                            .font(.system(size: 45))
                        Text("Logs")
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.purple)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.purple, lineWidth: 2)
                    )
                    .cornerRadius(10)
                    .padding(.horizontal, 5)
                }

            ProfileView()
                .tabItem {
                    VStack {
                        Image(systemName: "person.fill")
                            .font(.system(size: 35))
                        Text("Profile")
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.purple)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.purple, lineWidth: 2)
                    )
                    .cornerRadius(10)
                    .padding(.horizontal, 5)
                }
        }
    }
}

#Preview {
    Homepage()
}
