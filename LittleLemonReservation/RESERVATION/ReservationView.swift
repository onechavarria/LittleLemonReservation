
import SwiftUI

// Vista que presenta los datos de la última reserva.
// Recibe la información desde MainView.
struct ReservationView: View {

    let reservation: Reservation?

    var body: some View {

        NavigationStack {

            Group {

                if let reservation = reservation {

                    // Muestra los detalles cuando existe
                    // una reserva válida y confirmada.
                    ScrollView {

                        VStack(
                            alignment: .leading,
                            spacing: 20
                        ) {

                            Label(
                                "Reservation Confirmed",
                                systemImage: "checkmark.circle.fill"
                            )
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.green)

                            Divider()

                            detailRow(
                                "Restaurant",
                                reservation.restaurant.city
                            )

                            detailRow(
                                "Location",
                                reservation.restaurant.neighborhood
                            )

                            detailRow(
                                "Date",
                                reservation.date.formatted(
                                    date: .abbreviated,
                                    time: .shortened
                                )
                            )

                            detailRow(
                                "Party",
                                "\(reservation.partySize)"
                            )

                            detailRow(
                                "Name",
                                reservation.customerName
                            )

                            detailRow(
                                "Phone",
                                reservation.customerPhone
                            )

                            detailRow(
                                "E-mail",
                                reservation.customerEmail
                            )

                            if !reservation.specialRequests.isEmpty {

                                detailRow(
                                    "Special Requests",
                                    reservation.specialRequests
                                )
                            }
                        }
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                        .padding(24)
                    }

                } else {

                    // Estado vacío cuando el usuario
                    // todavía no ha confirmado una reserva.
                    ContentUnavailableView(
                        "No Reservation",
                        systemImage: "calendar.badge.clock",
                        description: Text(
                            "Select a restaurant to make a reservation."
                        )
                    )
                }
            }
            .navigationTitle("My Reservation")
        }
    }

    // Componente reutilizable para presentar
    // las etiquetas y valores de una reserva.
    private func detailRow(
        _ title: String,
        _ value: String
    ) -> some View {

        VStack(alignment: .leading, spacing: 6) {

            Text(title.uppercased())
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(value)
                .font(.body)
                .foregroundStyle(.primary)
        }
    }
}
