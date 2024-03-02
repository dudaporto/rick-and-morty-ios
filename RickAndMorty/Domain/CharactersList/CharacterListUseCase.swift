import RickAndMortyAPI

protocol CharacterListUseCaseProtocol {
    func fetchCharacters(
        search: String,
        success: @escaping (CharacterListResponse) -> Void,
        failure: @escaping () -> Void
    )
}

final class CharacterListUseCase: CharacterListUseCaseProtocol {
    private let repository: RepositoryProtocol
    
    init(repository: RepositoryProtocol = Repository()) {
        self.repository = repository
    }
    
    func fetchCharacters(
        search: String,
        success: @escaping (CharacterListResponse) -> Void,
        failure: @escaping () -> Void
    ) {
        repository.fetch(query: CharacterListQuery(search: .some(search))) { result in
            switch result {
            case .success(let graphQLResponse):
                guard let response = CharacterListResponse(data: graphQLResponse.characters) else {
                    fallthrough
                }

                success(response)
                
            case .failure:
                failure()
            }
        }
    }
}
