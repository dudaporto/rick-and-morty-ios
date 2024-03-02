import RickAndMortyAPI

protocol CharacterListUseCaseProtocol {
    func fetchCharacters(
        success: @escaping (CharacterListResponse) -> Void,
        failure: @escaping () -> Void
    )
}

final class CharacterListUseCase {
    private let repository: RepositoryProtocol
    
    init(repository: RepositoryProtocol = Repository()) {
        self.repository = repository
    }
    
    func fetchCharacters(
        success: @escaping (CharacterListResponse) -> Void,
        failure: @escaping () -> Void
    ) {
        repository.fetch(query: CharacterListQuery()) { result in
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
