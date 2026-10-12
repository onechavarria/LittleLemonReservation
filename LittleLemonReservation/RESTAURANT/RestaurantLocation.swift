
import Foundation

// Modelo de datos de una sucursal.
// Identifiable permite representar cada restaurante
// individualmente dentro de listas de SwiftUI.
struct RestaurantLocation: Identifiable, Hashable {

    let id: String
    let city: String
    let neighborhood: String
    let phone: String

    // Descripción completa del restaurante.
    var fullLocation: String {
        "\(city) - \(neighborhood)"
    }
}
