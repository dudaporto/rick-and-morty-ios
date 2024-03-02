import class UIKit.UIViewController

enum CharacterListFactory {
    static func build() -> UIViewController {
        let viewModel = CharacterListViewModel()
        let viewController = CharacterListViewController(viewModel: viewModel)
        
        viewModel.view = viewController
        return viewController
    }
}
