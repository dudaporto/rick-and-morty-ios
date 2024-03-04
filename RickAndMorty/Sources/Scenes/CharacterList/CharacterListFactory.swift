import class UIKit.UIViewController

enum CharacterListFactory {
    static func build(coordinator: CoordinatorProtocol) -> UIViewController {
        let viewModel = CharacterListViewModel(coordinator: coordinator)
        let viewController = CharacterListViewController(viewModel: viewModel)
        
        viewModel.view = viewController
        return viewController
    }
}
