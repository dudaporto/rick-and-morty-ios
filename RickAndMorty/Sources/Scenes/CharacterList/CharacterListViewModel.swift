protocol CharacterListViewModelProtocol {
    func fetchCharacters()
}

final class CharacterListViewModel {
    weak var view: CharacterListViewProtocol?
    
    private let useCase: CharacterListUseCaseProtocol
    private let adapter = CharacterListAdapter()
    
    init(useCase: CharacterListUseCaseProtocol = CharacterListUseCase()) {
        self.useCase = useCase
    }
    
//    func loadContent(characterName: String?) {
//        clearList()
//        viewController?.startLoading()
//        filter.name = characterName
//        fetchCharacters()
//    }
    
    func fetchCharacters() {
        view?.startLoading()
        
        useCase.fetchCharacters { [weak self] response in
            guard let self else { return }
            
            self.adapter.characters = response.characters
            self.view?.stopLoading()
            self.view?.displayCharacters(adapter: adapter)
            
        } failure: {
            print("Erro")
        }
    }
}

extension CharacterListViewModel: CharacterListViewModelProtocol {
    
}
