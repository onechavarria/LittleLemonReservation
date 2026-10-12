
import SwiftUI

// Formulario de reservas de Little Lemon.
// Recibe el restaurante seleccionado y un Binding
// para compartir la reserva con la vista principal.
struct ReservationForm: View {

    let restaurant: RestaurantLocation

    @Binding var savedReservation: Reservation?

    @Environment(\.dismiss) private var dismiss

    // Variables de estado utilizadas por los controles.
    @State private var reservationDate = Date()
    @State private var partySize = 1
    @State private var customerName = ""
    @State private var customerPhone = ""
    @State private var customerEmail = ""
    @State private var specialRequests = ""

    // Variables para mostrar los errores de validación.
    @State private var showError = false
    @State private var errorMessages: [String] = []

    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 24) {

                // Datos del restaurante seleccionado.
                VStack(alignment: .leading, spacing: 5) {

                    Text(restaurant.city)
                        .font(.title2)
                        .fontWeight(.medium)

                    Text(
                        "\(restaurant.neighborhood) - \(restaurant.phone)"
                    )
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                    Divider()
                }

                // Selección de personas, fecha y hora.
                VStack(alignment: .leading, spacing: 14) {

                    Text("PARTY")
                        .font(.headline)

                    Stepper(
                        value: $partySize,
                        in: 1...20
                    ) {
                        Text("\(partySize) person(s)")
                    }

                    DatePicker(
                        "DATE & TIME",
                        selection: $reservationDate,
                        in: Date()...,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                }

                Divider()

                // Campos de información del cliente.
                VStack(alignment: .leading, spacing: 18) {

                    HStack {
                        Text("NAME:")
                            .fontWeight(.medium)

                        TextField(
                            "Your name...",
                            text: $customerName
                        )
                        .textContentType(.name)
                        .textInputAutocapitalization(.words)
                    }

                    Divider()

                    HStack {
                        Text("PHONE:")
                            .fontWeight(.medium)

                        TextField(
                            "Your phone number...",
                            text: $customerPhone
                        )
                        .keyboardType(.phonePad)
                        .textContentType(.telephoneNumber)
                    }

                    Divider()

                    HStack {
                        Text("E-MAIL:")
                            .fontWeight(.medium)

                        TextField(
                            "Your e-mail...",
                            text: $customerEmail
                        )
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    }

                    Divider()
                }

                // Campo opcional de observaciones.
                TextField(
                    "Add any special request (optional)",
                    text: $specialRequests,
                    axis: .vertical
                )
                .lineLimit(2...4)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.gray.opacity(0.3))
                )

                Divider()

                // Botón que inicia la validación.
                Button(action: validateAndReserve) {

                    Text("CONFIRM RESERVATION")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                }
                .buttonStyle(.borderedProminent)
                .clipShape(Capsule())
            }
            .padding(22)
        }
        .navigationTitle("Reservation")
        .navigationBarTitleDisplayMode(.inline)

        // Alerta que presenta los errores del formulario.
        .alert("ERROR", isPresented: $showError) {

            Button("OK", role: .cancel) {}

        } message: {

            Text(errorMessages.joined(separator: "\n\n"))
        }
    }

    // Valida los campos obligatorios y acumula
    // los mensajes de error correspondientes.
    private func validateAndReserve() {

        errorMessages.removeAll()

        let name = customerName.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        let phone = customerPhone.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        let email = customerEmail.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        // Validación del nombre: mínimo tres letras,
        // permitiendo espacios entre nombres y apellidos.
        let nameCharacters = name.filter {
            $0.isLetter
        }

        let nameIsValid =
            nameCharacters.count >= 3 &&
            name.allSatisfy {
                $0.isLetter || $0.isWhitespace
            }

        if !nameIsValid {
            errorMessages.append(
                "Names can only contain letters and must have at least 3 characters."
            )
        }

        // Validación del teléfono: permite espacios,
        // guiones, paréntesis y el signo +.
        let phoneDigits = phone.filter {
            $0.isNumber
        }

        let phoneIsValid =
            (7...15).contains(phoneDigits.count) &&
            phone.allSatisfy {
                $0.isNumber ||
                " +-()".contains($0)
            }

        if !phoneIsValid {
            errorMessages.append(
                "Enter a valid phone number with 7 to 15 digits."
            )
        }

        // Validación básica de la estructura del correo.
        let emailPattern =
            #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#

        let emailIsValid = email.range(
            of: emailPattern,
            options: .regularExpression
        ) != nil

        if !emailIsValid {
            errorMessages.append(
                "The e-mail is invalid and cannot be blank."
            )
        }

        // Comprueba que la reserva tenga una cantidad
        // válida de personas y una fecha no pasada.
        if !(1...20).contains(partySize) {
            errorMessages.append(
                "The party size must be between 1 and 20."
            )
        }

        if reservationDate < Date() {
            errorMessages.append(
                "The reservation date cannot be in the past."
            )
        }

        // Si existen errores, se activa la alerta
        // y no se registra la reserva.
        guard errorMessages.isEmpty else {
            showError = true
            return
        }

        // Crea la reserva, comparte el resultado
        // y regresa a la pantalla de ubicaciones.
        savedReservation = Reservation(
            restaurant: restaurant,
            date: reservationDate,
            partySize: partySize,
            customerName: name,
            customerPhone: phone,
            customerEmail: email,
            specialRequests: specialRequests
        )

        dismiss()
    }
}
