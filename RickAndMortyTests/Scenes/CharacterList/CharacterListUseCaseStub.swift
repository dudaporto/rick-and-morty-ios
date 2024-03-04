import Foundation

@testable import RickAndMorty

final class CharacterListUseCaseStub: CharacterListUseCaseProtocol {
    var mockResult: Result<CharacterListResponse, CharacterListError>?
    
    private(set) var calledPage: Int?
    private(set) var calledSearch: String?
    
    func fetchCharacters(
        page: Int,
        search: String,
        success: @escaping (CharacterListResponse) -> Void,
        failure: @escaping (CharacterListError) -> Void
    ) {
        calledPage = page
        calledSearch = search
        switch mockResult {
        case .success(let response):
            success(response)
        case .failure(let error):
            failure(error)
        case .none:
            break
        }
    }
}
