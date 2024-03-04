import class UIKit.UIViewController

enum CharacterDetailsFactory {
    static func build(characterSummary: CharacterListResponse.Character) -> UIViewController {
        let viewModel = CharacterDetailsViewModel(characterSummary: characterSummary)
        let viewController = CharacterDetailsViewController(viewModel: viewModel)
        
        viewModel.view = viewController
        return viewController
    }
}
