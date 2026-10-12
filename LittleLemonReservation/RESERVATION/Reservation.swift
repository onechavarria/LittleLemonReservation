
import Foundation

// Modelo que representa una reserva confirmada.
// Cada reserva tiene un identificador único.
struct Reservation: Identifiable {

    let id: UUID
    let restaurant: RestaurantLocation
    let date: Date
    let partySize: Int
    let customerName: String
    let customerPhone: String
    let customerEmail: String
    let specialRequests: String

    // Inicializador utilizado al confirmar el formulario.
    init(
        restaurant: RestaurantLocation,
        date: Date,
        partySize: Int,
        customerName: String,
        customerPhone: String,
        customerEmail: String,
        specialRequests: String
    ) {
        self.id = UUID()
        self.restaurant = restaurant
        self.date = date
        self.partySize = partySize
        self.customerName = customerName
        self.customerPhone = customerPhone
        self.customerEmail = customerEmail
        self.specialRequests = specialRequests
    }
}
