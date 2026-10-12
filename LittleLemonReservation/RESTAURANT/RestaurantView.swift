
import SwiftUI

// Componente reutilizable que muestra la ciudad,
// el barrio y el teléfono de una sucursal.
struct RestaurantView: View {

    let restaurant: RestaurantLocation

    var body: some View {

        VStack(alignment: .leading, spacing: 5) {

            // Nombre principal de la ciudad.
            Text(restaurant.city)
                .font(.system(size: 21))
                .foregroundStyle(.primary)

            // Información secundaria de la sucursal.
            HStack(spacing: 8) {

                Text(restaurant.neighborhood)

                Text("–")

                Text(restaurant.phone)
            }
            .font(.system(size: 13))
            .foregroundStyle(.secondary)
        }
        .padding(.vertical, 6)
    }
}

// Vista previa con una ubicación de ejemplo.
#Preview {
    RestaurantView(
        restaurant: RestaurantData.locations[0]
    )
}
