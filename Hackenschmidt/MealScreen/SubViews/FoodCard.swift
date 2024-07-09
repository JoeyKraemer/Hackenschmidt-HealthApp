import SwiftUI

struct FoodCard: View {
    var food: Food
    @Binding var isChecked: Bool

    var body: some View {
        HStack {
            Text(food.food_name)
                .foregroundColor(Color("TextColor"))

            Spacer()

            Image(systemName: isChecked ? "checkmark.square" : "square")
                .foregroundColor(isChecked ? Color.green : Color.gray)
                .onTapGesture {
                    isChecked.toggle()
                }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}
