import UIKit

final class HomeViewController: UIViewController {
    private let useCase = CharacterListUseCase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        useCase.fetchCharacters { [weak self] response in
            print(response.characters)
            self?.view.backgroundColor = .green
        } failure: { [weak self] in
            print("ERRO")
            self?.view.backgroundColor = .red
        }
    }
}
