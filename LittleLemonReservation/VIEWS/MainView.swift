
import SwiftUI

// Vista principal que coordina las pantallas.
// Conserva la última reserva confirmada y comparte
// su información entre las pestañas de la aplicación.
struct MainView: View {

    // Estado compartido de la reserva.
    @State private var savedReservation: Reservation?

    var body: some View {

        TabView {

            // Primera pestaña: lista de restaurantes.
            LocationsView(
                savedReservation: $savedReservation
            )
            .tabItem {
                Label(
                    "Locations",
                    systemImage: "fork.knife"
                )
            }

            // Segunda pestaña: reserva confirmada.
            ReservationView(
                reservation: savedReservation
            )
            .tabItem {
                Label(
                    "Reservation",
                    systemImage: "square.and.pencil"
                )
            }
        }
        .tint(.blue)
    }
}

// Vista previa del contenedor principal.
#Preview {
    MainView()
}
