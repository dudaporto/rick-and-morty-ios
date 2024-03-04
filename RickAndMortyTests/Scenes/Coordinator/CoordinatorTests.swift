import UIKit
import XCTest

@testable import RickAndMorty

private final class NavigationSpy: UINavigationController {
    private(set) var callPushCount = 0
    private(set) var pushedViewController: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        callPushCount += 1
        pushedViewController = viewController
    }
}

final class CoordinatorTests: XCTestCase {
    private let spy = NavigationSpy()
    private lazy var sut = Coordinator(navigationController: spy)
    
    func testStart_WhenEventIsCharacterList_ShouldPushCharacterListView() {
        sut.start(event: .characterList)
        
        XCTAssertEqual(spy.callPushCount, 1)
        XCTAssertTrue(spy.pushedViewController is CharacterListViewController)
    }
    
    func testStart_WhenEventIsCharacterLssist_ShouldPushCharacterListView() throws {
        let summaryMock = try XCTUnwrap(CharacterListMock.data?.characters.first)
        sut.start(event: .characterDetails(summary: summaryMock))
        
        XCTAssertEqual(spy.callPushCount, 1)
        XCTAssertTrue(spy.pushedViewController is CharacterDetailsViewController)
    }
}
