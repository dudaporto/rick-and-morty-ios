import XCTest

@testable import RickAndMorty

private final class Spy: CharacterDetailsViewProtocol {
    enum Method {
        case displayInfo,
             displayHeader,
             displayError,
             startLoading,
             setImage
    }
    
    private(set) var calledMethods: [Method] = []
    private(set) var calledAdapter: CharacterDetailsAdapter?
    
    func displayInfo(adapter: CharacterDetailsAdapter) {
        calledAdapter = adapter
        calledMethods.append(.displayInfo)
    }
    
    func displayHeader(name: String, statusColor: UIColor, statusDescription: String) {
        calledMethods.append(.displayHeader)
    }
    
    func displayError() {
        calledMethods.append(.displayError)
    }
    
    func startLoading() {
        calledMethods.append(.startLoading)
    }
    
    func setImage(_ image: UIImage) {
        calledMethods.append(.setImage)
    }
    
    var currentDownloadTask: Cancellable?
}

final class CharacterDetailsTest: XCTestCase {
    private let characterSummaryMock = CharacterListMock.data?.characters.first
    private let spy = Spy()
    private let imageRepositorySpy = ImageRepositorySpy()
    private let useCaseStub = CharacterDetailsUseCaseStub()
    
    private lazy var sut: CharacterDetailsViewModel? = {
        guard let characterSummaryMock else { return nil }
        let sut = CharacterDetailsViewModel(
            characterSummary: characterSummaryMock,
            useCase: useCaseStub,
            imageRepository: imageRepositorySpy
        )
        sut.view = spy
        return sut
    }()
    
    func testLoadContent_WhenResultIsSuccess_ShouldDisplayInfo() throws {
        let unwrappedSut = try XCTUnwrap(sut)
        useCaseStub.mockResult = CharacterDetailsMock.data
        
        unwrappedSut.loadContent()
        
        XCTAssertEqual(spy.calledMethods, [.displayHeader, .setImage, .startLoading, .displayInfo])
        XCTAssertEqual(spy.calledAdapter?.character, CharacterDetailsMock.data)
        XCTAssertEqual(imageRepositorySpy.callLoadCount, 1)
        XCTAssertEqual(imageRepositorySpy.calledImageUrlPath, characterSummaryMock?.imageUrl)
    }
    
    func testLoadContent_WhenResultIsFailure_ShouldDisplayInfo() throws {
        let unwrappedSut = try XCTUnwrap(sut)
        useCaseStub.mockResult = nil
        
        unwrappedSut.loadContent()
        
        XCTAssertEqual(spy.calledMethods, [.displayHeader, .setImage, .startLoading, .displayError])
        XCTAssertEqual(spy.calledAdapter?.character, nil)
        XCTAssertEqual(imageRepositorySpy.callLoadCount, 1)
        XCTAssertEqual(imageRepositorySpy.calledImageUrlPath, characterSummaryMock?.imageUrl)
    }
}
