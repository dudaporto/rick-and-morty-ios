import Foundation

@testable import RickAndMorty

final class CharacterDetailsUseCaseStub: CharacterDetailsUseCaseProtocol {
    var mockResult: CharacterDetailsResponse?
    
    func fetchCharacter(
        id: String,
        success: @escaping (CharacterDetailsResponse) -> Void,
        failure: @escaping () -> Void
    ) {
        if let mockResult {
            success(mockResult)
        } else {
            failure()
        }
    }
}
