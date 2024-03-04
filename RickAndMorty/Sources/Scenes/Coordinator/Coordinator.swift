import UIKit

enum AppEvent {
    case characterList
    case characterDetails(summary: CharacterListResponse.Character)
}

protocol CoordinatorProtocol {
    func start(event: AppEvent)
}

final class Coordinator: CoordinatorProtocol {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(event: AppEvent) {
        switch event {
        case .characterList:
            let viewController = CharacterListFactory.build(coordinator: self)
            navigationController.pushViewController(viewController, animated: true)
        
        case .characterDetails(let summary):
            let viewController = CharacterDetailsFactory.build(characterSummary: summary)
            navigationController.pushViewController(viewController, animated: true)
        }
    }
}
