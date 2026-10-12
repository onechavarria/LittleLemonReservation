
import SwiftUI

// Vista principal con las ubicaciones de Little Lemon.
// Comparte la reserva confirmada mediante @Binding.
struct LocationsView: View {

    @Binding var savedReservation: Reservation?

    // Estado que determina qué texto se muestra.
    @State private var displayingReservationForm = false

    var body: some View {

        NavigationStack {

            VStack(spacing: 12) {

                // Logotipo del restaurante.
                LittleLemonLogo()
                    .padding(.top, 25)
                    .padding(.horizontal, 24)

                // Texto dinámico según el formulario.
                Text(
                    displayingReservationForm
                    ? "Reservation Details"
                    : "Select a location"
                )
                .font(.headline)
                .padding(.horizontal, 36)
                .padding(.vertical, 10)
                .background(Color.gray.opacity(0.16))
                .clipShape(Capsule())

                // Lista dinámica de sucursales.
                List(RestaurantData.locations) { restaurant in

                    NavigationLink {

                        // Abre el formulario del restaurante.
                        ReservationForm(
                            restaurant: restaurant,
                            savedReservation: $savedReservation
                        )
                        .onAppear {
                            displayingReservationForm = true
                        }
                        .onDisappear {
                            displayingReservationForm = false
                        }

                    } label: {

                        RestaurantView(
                            restaurant: restaurant
                        )
                    }
                }
                .listStyle(.plain)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
