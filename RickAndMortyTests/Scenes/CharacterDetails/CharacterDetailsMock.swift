import Foundation
@testable import RickAndMorty

enum CharacterDetailsMock {
    private static let mock = """
    {
      "species": "Human",
      "gender": "Male",
      "origin": "Earth (C-137)",
      "episodes": [
        {
          "name": "Pilot",
          "code": "S01E01"
        },
        {
          "name": "Lawnmower Dog",
          "code": "S01E02"
        }
      ]
    }
    """.data(using: .utf8) ?? Data()
    
    static var data: CharacterDetailsResponse? {
        try? JSONDecoder().decode(CharacterDetailsResponse.self, from: mock)
    }
}
