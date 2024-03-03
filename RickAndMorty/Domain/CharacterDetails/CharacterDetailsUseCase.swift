import RickAndMortyAPI

protocol CharacterDetailsUseCaseProtocol {
    func fetchCharacter(
        id: String,
        success: @escaping (CharacterDetailsResponse) -> Void,
        failure: @escaping () -> Void
    )
}

final class CharacterDetailsUseCase: CharacterDetailsUseCaseProtocol {
    private let repository: RepositoryProtocol
    
    init(repository: RepositoryProtocol = Repository()) {
        self.repository = repository
    }
    
    func fetchCharacter(
        id: String,
        success: @escaping (CharacterDetailsResponse) -> Void,
        failure: @escaping () -> Void
    ) {
        let query = CharacterDetailsQuery(id: id)
        repository.fetch(query: query) { result in
            switch result {
            case .success(let graphQLResponse):
                guard let response = CharacterDetailsResponse(data: graphQLResponse.character) else {
                    fallthrough
                }

                success(response)
                
            case .failure:
                failure()
            }
        }
    }
}

