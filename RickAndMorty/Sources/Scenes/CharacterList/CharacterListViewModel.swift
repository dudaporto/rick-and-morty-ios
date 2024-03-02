import Foundation

protocol CharacterListViewModelProtocol {
    func loadContent()
    func didSearch(_ name: String)
}

final class CharacterListViewModel {
    weak var view: CharacterListViewProtocol?
    
    private let useCase: CharacterListUseCaseProtocol
    private let adapter = CharacterListAdapter()
    
    private var searchTimer: Timer?
    
    init(useCase: CharacterListUseCaseProtocol = CharacterListUseCase()) {
        self.useCase = useCase
    }
    
    // Debounce search
    func didSearch(_ name: String) {
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            self?.fetchCharacters(search: name)
        }
    }
    
    func clearList() {
        adapter.characters = []
        view?.displayCharacters(adapter: adapter)
    }
    
    func loadContent() {
        fetchCharacters(search: "")
    }
}

private extension CharacterListViewModel {
    func fetchCharacters(search: String) {
        clearList()
        view?.startLoading()
        
        useCase.fetchCharacters(search: search) { [weak self] response in
            guard let self else { return }
            self.adapter.characters = response.characters
            self.view?.stopLoading()
            self.view?.displayCharacters(adapter: self.adapter)
            
        } failure: {
            print("Erro")
        }
    }
}

extension CharacterListViewModel: CharacterListViewModelProtocol {
    
}
