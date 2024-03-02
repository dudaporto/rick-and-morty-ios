import RickAndMortyAPI

protocol CharacterListUseCaseProtocol {
    func fetchCharacters(
        page: Int,
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
        page: Int,
        search: String,
        success: @escaping (CharacterListResponse) -> Void,
        failure: @escaping () -> Void
    ) {
        let query = CharacterListQuery(page: .some(page), search: .some(search))
        repository.fetch(query: query) { result in
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
