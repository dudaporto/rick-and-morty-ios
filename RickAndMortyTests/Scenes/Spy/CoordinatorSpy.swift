@testable import RickAndMorty

final class CoordinatorSpy: CoordinatorProtocol {
    private(set) var calledEvent: AppEvent?
    
    func start(event: AppEvent) {
        calledEvent = event
    }
}
