import Foundation
@testable import RickAndMorty

enum CharacterListMock {
    private static let mock = """
    {
        "nextPage": 2,
        "characters" : [
            {
              "id": "1",
              "name": "Rick Sanchez",
              "imageUrl": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
              "location": "Citadel of Ricks",
              "status": "Alive"
            },
            {
              "id": "2",
              "name": "Morty Smith",
              "imageUrl": "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
              "location": "Citadel of Ricks",
              "status": "Alive"
            }
          ]
    }
    """.data(using: .utf8) ?? Data()
    
    static var data: CharacterListResponse? {
        try? JSONDecoder().decode(CharacterListResponse.self, from: mock)
    }
}
