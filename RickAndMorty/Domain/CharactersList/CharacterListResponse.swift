import RickAndMortyAPI

struct CharacterListResponse {
    let characters: [Character]
    let nextPage: Int?
    
    init?(data: CharacterListQuery.Data.Characters?) {
        guard let results = data?.results else { return nil }
        self.characters = results.compactMap { Character(data: $0) }
        self.nextPage = data?.info?.next
    }
    
    struct Character {
        let id: String
        let name: String
        let location: String
        let status: Status
        let imageUrl: String?
        
        init?(data: CharacterListQuery.Data.Characters.Result?) {
            guard let id = data?.id,
                  let name = data?.name,
                  let location = data?.location?.name,
                  let status = Status(rawValue: data?.status ?? "") else {
                return nil
            }
            
            self.id = id
            self.name = name
            self.location = location
            self.status = status
            self.imageUrl = data?.image
        }
        
        @frozen
        enum Status: String {
            case alive = "Alive"
            case dead = "Dead"
            case unknown
        }
    }
}
