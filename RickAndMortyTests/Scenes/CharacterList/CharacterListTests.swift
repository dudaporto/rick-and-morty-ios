import XCTest

@testable import RickAndMorty

private final class Spy: CharacterListViewProtocol {
    enum Method {
        case displayCharacters,
             displaySearchError,
             displayServerError,
             startLoading,
             stopLoading
    }
    
    private(set) var calledMethods: [Method] = []
    private(set) var calledAdapter: CharacterListAdapter?
    private(set) var calledSearchName: String?
    
    func displayCharacters(adapter: CharacterListAdapter) {
        calledAdapter = adapter
        calledMethods.append(.displayCharacters)
    }
    
    func displaySearchError(name: String) {
        calledSearchName = name
        calledMethods.append(.displaySearchError)
    }
    
    func displayServerError() {
        calledMethods.append(.displayServerError)
    }
    
    func startLoading() {
        calledMethods.append(.startLoading)
    }
    
    func stopLoading() {
        calledMethods.append(.stopLoading)
    }
}

final class CharacterListTests: XCTestCase {
    private let spy = Spy()
    private let useCaseStub = CharacterListUseCaseStub()
    
    private lazy var sut: CharacterListViewModel = {
        let sut = CharacterListViewModel(useCase: useCaseStub)
        sut.view = spy
        return sut
    }()
    
    func testLoadContent_WhenResultIsSuccess_ShouldDisplayCharacters() throws {
        let mock = try XCTUnwrap(CharacterListMock.data)
        useCaseStub.mockResult = .success(mock)
        
        sut.loadContent()
        
        XCTAssertEqual(spy.calledMethods, [.displayCharacters, .startLoading, .stopLoading, .displayCharacters])
        XCTAssertEqual(spy.calledAdapter?.characters, mock.characters)
        XCTAssertTrue(spy.calledAdapter?.showSeeMore == true)
    }
    
    func testLoadContent_WhenResultIsServerFailure_ShouldDisplayServerError() {
        useCaseStub.mockResult = .failure(.server)
        
        sut.loadContent()
        
        XCTAssertEqual(spy.calledMethods, [.displayCharacters, .startLoading, .stopLoading, .displayServerError])
        XCTAssertEqual(spy.calledAdapter?.characters, [])
        XCTAssertTrue(spy.calledAdapter?.showSeeMore == false)
    }
    
    func testDidSearch_WhenResultIsSearchFailure_ShouldDisplaySearchError() {
        let name = "Sample"
        useCaseStub.mockResult = .failure(.search(name: name))
        
        sut.didSearch(name)
        
        let _ = XCTWaiter.wait(for: [expectation(description: "Wait typing delay")], timeout: 0.5)
        XCTAssertEqual(spy.calledMethods, [.displayCharacters, .startLoading, .stopLoading, .displaySearchError])
        XCTAssertEqual(spy.calledSearchName, name)
        XCTAssertEqual(spy.calledAdapter?.characters, [])
        XCTAssertTrue(spy.calledAdapter?.showSeeMore == false)
    }
    
    func testDidSearch_WhenResultIsSearchSuccess_ShouldDisplayCharacters() throws {
        let name = "Sample"
        let mock = try XCTUnwrap(CharacterListMock.data)
        useCaseStub.mockResult = .success(mock)
        
        sut.didSearch(name)
        
        let _ = XCTWaiter.wait(for: [expectation(description: "Wait typing delay")], timeout: 0.5)
        XCTAssertEqual(spy.calledMethods, [.displayCharacters, .startLoading, .stopLoading, .displayCharacters])
        XCTAssertEqual(useCaseStub.calledSearch, name)
        XCTAssertEqual(spy.calledAdapter?.characters, mock.characters)
        XCTAssertTrue(spy.calledAdapter?.showSeeMore == true)
    }
    
    func testLoadMore_WhenResultIsSuccess_ShouldDisplayMoreCharacters() throws {
        let mock = try XCTUnwrap(CharacterListMock.data)
        useCaseStub.mockResult = .success(mock)
        
        sut.loadMore()
        
        XCTAssertEqual(spy.calledMethods, [.stopLoading, .displayCharacters])
        XCTAssertEqual(spy.calledAdapter?.characters, mock.characters)
        XCTAssertTrue(spy.calledAdapter?.showSeeMore == true)
        XCTAssertEqual(useCaseStub.calledPage, 2)
    }
}
