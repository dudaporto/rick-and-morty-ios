import UIKit

final class HomeViewController: UIViewController {
    private let useCase = CharacterListUseCase()
    
    private lazy var label = UILabel.build(type: .largeTitle, color: Color.gray3.color)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
        view.backgroundColor = .white
                
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        useCase.fetchCharacters { [weak self] response in
            print(response.characters)
            self?.label.text = response.characters.first?.name
        } failure: { [weak self] in
            print("ERRO")
            self?.view.backgroundColor = .red
        }
    }
}
