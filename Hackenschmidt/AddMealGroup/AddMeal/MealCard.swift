import SwiftUI

struct MealCard: View {
    var name: String
    var foods: [String]
    var calories: Int

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(name)
                    .font(.system(size: 20, weight: .bold))
                    .bold()
                Text(foods.joined(separator: ", "))
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer()
            VStack {
                ZStack {
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 50, height: 50)
                    VStack {
                        Text("\(calories)")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(Color.black)
                        Text("cal")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(Color.black)
                    }
                }
            }
        }
        .padding()
        .background(Color("NormalBackground"))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
        .padding(.horizontal)
    }
}
