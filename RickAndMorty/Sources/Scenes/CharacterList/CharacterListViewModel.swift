import Foundation
import UIKit

protocol CharacterListViewModelProtocol {
    func loadContent()
    func didSearch(_ name: String)
    func loadMore()
    func didSelectCharacter(at row: Int)
}

final class CharacterListViewModel {
    weak var view: CharacterListViewProtocol?
    
    private let useCase: CharacterListUseCaseProtocol
    private let adapter = CharacterListAdapter()
    
    private var searchTimer: Timer?
    private var currentPage = 1
    private var search = ""
    
    init(useCase: CharacterListUseCaseProtocol = CharacterListUseCase()) {
        self.useCase = useCase
    }
}

private extension CharacterListViewModel {
    func fetchCharacters(isLoadingMore: Bool = false) {
        if !isLoadingMore {
            view?.startLoading()
        }
        
        useCase.fetchCharacters(page: currentPage, search: search) { [weak self] response in
            guard let self else { return }
            
            self.setupAdapter(response: response)
            self.view?.stopLoading()
            self.view?.displayCharacters(adapter: self.adapter)
            
        } failure: {
            print("Erro")
        }
    }
    
    func clearList() {
        currentPage = 1
        search = ""
        adapter.characters = []
        adapter.showSeeMore = false
        view?.displayCharacters(adapter: adapter)
    }
    
    func setupAdapter(response: CharacterListResponse) {
        adapter.characters.append(contentsOf: response.characters)
        adapter.showSeeMore = response.nextPage != nil
    }
}

extension CharacterListViewModel: CharacterListViewModelProtocol {
    // Debounce search
    func didSearch(_ name: String) {
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            self?.clearList()
            self?.search = name
            self?.fetchCharacters()
        }
    }
    
    func loadContent() {
        clearList()
        fetchCharacters()
    }
    
    func loadMore() {
        currentPage += 1
        fetchCharacters(isLoadingMore: true)
    }
    
    func didSelectCharacter(at row: Int) {
        let character = adapter.characters[row]

        let viewModel = CharacterDetailsViewModel(characterSummary: character)
        let view = CharacterDetailsViewController(viewModel: viewModel)

        viewModel.view = view

        (self.view as? UIViewController)?.navigationController?.pushViewController(view, animated: true)
    }
}
