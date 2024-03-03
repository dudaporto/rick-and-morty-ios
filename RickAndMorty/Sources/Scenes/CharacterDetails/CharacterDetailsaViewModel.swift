protocol CharacterDetailsViewModelProtocol {
    func loadContent()
}

final class CharacterDetailsViewModel {
    weak var view: CharacterDetailsViewProtocol?
    
    private let characterSummary: CharacterListResponse.Character
    private let useCase: CharacterDetailsUseCaseProtocol
    
    private let adapter = CharacterDetailsAdapter()
    
    init(
        characterSummary: CharacterListResponse.Character,
        useCase: CharacterDetailsUseCaseProtocol = CharacterDetailsUseCase()
    ) {
        self.characterSummary = characterSummary
        self.useCase = useCase
    }
}

extension CharacterDetailsViewModel: CharacterDetailsViewModelProtocol {
    func loadContent() {
        setupHeader()
        view?.startLoading()
        
        useCase.fetchCharacter(id: characterSummary.id) { [weak self] response in
            guard let self else { return }
            self.adapter.character = response
            self.view?.displayInfo(adapter: self.adapter)
        } failure: {
            print("error")
        }
    }
}

private extension CharacterDetailsViewModel {
    func setupHeader() {
        view?.displayHeader(
            name: characterSummary.name,
            statusColor: StatusColorBuilder.getColor(for: characterSummary.status),
            statusDescription: characterSummary.status.rawValue.capitalized
        )
        
        guard let view, let imageUrl = characterSummary.imageUrl else { return }
        ImageRepository.shared.load(for: view, imageUrlPath: imageUrl)
    }
}
