import RickAndMortyAPI

protocol CharacterListUseCaseProtocol {
    func fetchCharacters(
        page: Int,
        search: String,
        success: @escaping (CharacterListResponse) -> Void,
        failure: @escaping (CharacterListError) -> Void
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
        failure: @escaping (CharacterListError) -> Void
    ) {
        let query = CharacterListQuery(page: .some(page), search: .some(search))
        repository.fetch(query: query) { result in
            switch result {
            case .success(let graphQLResponse):
                guard let response = CharacterListResponse(data: graphQLResponse.characters) else {
                    fallthrough
                }
                
                if response.characters.isEmpty {
                    failure(.search(name: search))
                } else {
                    success(response)
                }
            case .failure:
                failure(.server)
            }
        }
    }
}
