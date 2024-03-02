import RickAndMortyAPI

struct CharacterListResponse {
    let characters: [Character]
    
    init?(data: CharacterListQuery.Data.Characters?) {
        guard let results = data?.results else { return nil }
        self.characters = results.compactMap { Character(data: $0) }
    }
    
    struct Character {
        let name: String
        let location: String
        let status: Status
        let imageUrl: String?
        
        init?(data: CharacterListQuery.Data.Characters.Result?) {
            guard let name = data?.name,
                  let location = data?.location?.name,
                  let status = Status(rawValue: data?.status ?? "") else {
                return nil
            }
            
            self.name = name
            self.location = location
            self.status = status
            self.imageUrl = data?.image
        }
        
        @frozen
        enum Status: String {
            case alive = "Alive"
            case dead = "Dead"
            case unknown = "unknown"
        }
    }
}
