import class UIKit.UIColor

struct CharacterListCellViewModel {
    private let character: CharacterListResponse.Character
    
    init(character: CharacterListResponse.Character) {
        self.character = character
    }
    
    var name: String { character.name }
    var statusColor: UIColor { StatusColorBuilder.getColor(for: character.status) }
    var statusDescription: String { character.status.rawValue.capitalized }
    var location: String { character.location.capitalized }
}
