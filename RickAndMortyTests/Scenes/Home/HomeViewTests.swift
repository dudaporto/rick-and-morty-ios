import XCTest

@testable import RickAndMorty

final class HomeViewTests: XCTestCase {
    private let coordinatorSpy = CoordinatorSpy()
    private lazy var sut = HomeViewController(coordinator: coordinatorSpy)
    
    func testShowCharactersList_ShouldCallCharactersListEvent() {
        sut.showCharacterList()
        
        guard case .characterList = coordinatorSpy.calledEvent else {
            XCTFail("Wrong app event called.")
            return
        }
    }
}
