
import SwiftUI

// Componente reutilizable del logotipo oficial.
// La imagen debe existir en Assets.xcassets
// con el nombre LittleLemonLogo.
struct LittleLemonLogo: View {

    var body: some View {

        Image("LittleLemonLogo")
            .resizable()
            .scaledToFit()
            .frame(maxWidth: 290)
            .accessibilityLabel("Little Lemon Restaurant")
            .padding(.horizontal, 16)
    }
}

// Vista previa del logotipo.
#Preview {
    LittleLemonLogo()
}
