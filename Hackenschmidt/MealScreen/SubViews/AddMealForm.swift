import SwiftUI

struct AddMealForm: View {
    @State private var mealName: String = ""

    var body: some View {
        ZStack {
            Color("NormalBackground").edgesIgnoringSafeArea(.all)

            VStack {
                VStack(alignment: .leading) {
                    Text("What is the Meal’s name?")
                        .foregroundStyle(Color("TextColor"))
                        .padding(.bottom, 20)
                    TextField("Name?", text: $mealName)
                        .frame(width: 313)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                }
                .padding(.bottom, 50)
                .padding(.top, 50)

                VStack(alignment: .leading) {
                    Text("Ingredients list")
                        .foregroundStyle(Color("TextColor"))
                        .padding(.bottom, 20)

                    NavigationLink(destination: ProductFormView()) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color.gray.opacity(0.0))
                                .frame(width: 340, height: 70)

                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.black)
                                .frame(width: 340, height: 70)

                            Text("Add a product")
                                .font(.system(size: 20))
                                .foregroundColor(Color("TextColor"))
                                .frame(width: 340, height: 70, alignment: .center)
                        }
                    }
                    .frame(width: 340, height: 70)
                    .buttonStyle(PlainButtonStyle())

                    NavigationLink(destination: FoodFormCameraView()) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color.gray.opacity(0.0))
                                .frame(width: 340, height: 70)

                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.black)
                                .frame(width: 340, height: 70)

                            Text("Add a product with Camera")
                                .font(.system(size: 20))
                                .foregroundColor(Color("TextColor"))
                                .frame(width: 340, height: 70, alignment: .center)
                        }
                    }
                    .frame(width: 340, height: 70)
                    .buttonStyle(PlainButtonStyle())
                }
                Spacer()

                NavigationLink(
                    destination: AddMealView(),
                    label: {
                        Text("ADD")
                            .frame(width: 340, height: 40)
                            .foregroundColor(Color.white)
                            .background(Color("ButtonColor"))
                            .cornerRadius(5)
                    }
                )
            }
            .padding()
        }
    }
}

#Preview {
    AddMealForm()
}
