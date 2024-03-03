import RickAndMortyAPI

struct CharacterDetailsResponse {
    let species: String
    let gender: Gender
    let origin: String
    let episodes: [Episode]
    
    init?(data: CharacterDetailsQuery.Data.Character?) {
        guard let species = data?.species,
              let gender = Gender(rawValue: data?.gender ?? ""),
              let origin = data?.origin?.name else {
            return nil
        }
        
        self.species = species
        self.gender = gender
        self.origin = origin
        self.episodes = data?.episode.compactMap{ $0 }.compactMap{ Episode(data: $0) } ?? []
    }
    
    struct Episode {
        let name: String
        let code: String
        
        init?(data: CharacterDetailsQuery.Data.Character.Episode) {
            guard let code = data.episode, let name = data.name else {
                return nil
            }
            
            self.name = name
            self.code = code
        }
    }
    
    @frozen
    enum Gender: String {
        case female = "Female"
        case male = "Male"
        case genderless = "Genderless"
        case unknown
    }
}
