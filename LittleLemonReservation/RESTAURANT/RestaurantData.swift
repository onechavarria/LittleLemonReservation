import Foundation

// Fuente de datos local para las ubicaciones.
// Mantiene la información separada de la interfaz.
enum RestaurantData {

    static let locations: [RestaurantLocation] = [

        RestaurantLocation(
            id: "las-vegas-downtown",
            city: "Las Vegas",
            neighborhood: "Downtown",
            phone: "(702) 555-9898"
        ),

        RestaurantLocation(
            id: "los-angeles-north",
            city: "Los Angeles",
            neighborhood: "North Hollywood",
            phone: "(213) 555-1453"
        ),

        RestaurantLocation(
            id: "los-angeles-venice",
            city: "Los Angeles",
            neighborhood: "Venice",
            phone: "(310) 555-1222"
        ),

        RestaurantLocation(
            id: "nevada-venice",
            city: "Nevada",
            neighborhood: "Venice",
            phone: "(725) 555-5454"
        ),

        RestaurantLocation(
            id: "san-francisco-beach",
            city: "San Francisco",
            neighborhood: "North Beach",
            phone: "(415) 555-1345"
        ),

        RestaurantLocation(
            id: "san-francisco-union",
            city: "San Francisco",
            neighborhood: "Union Square",
            phone: "(415) 555-9813"
        )
    ]
}
