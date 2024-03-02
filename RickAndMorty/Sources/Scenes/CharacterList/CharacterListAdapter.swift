import UIKit

final class CharacterListAdapter: NSObject, UITableViewDataSource {
    enum Section: Int, CaseIterable {
        case characters
        case seeMore
    }
    
    var characters: [CharacterListResponse.Character] = []
    
    func numberOfSections(in tableView: UITableView) -> Int {
        Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        
        switch section {
        case .characters:
            return characters.count
        case .seeMore:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .characters:
            return characterCell(for: indexPath, tableView: tableView)
        case .seeMore:
            return UITableViewCell()
        }
    }
}

private extension CharacterListAdapter {
    func characterCell(for indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterListCell.identifier, for: indexPath)
        guard let characterCell = cell as? CharacterListCell,
              characters.indices.contains(indexPath.row) else {
            return UITableViewCell()
        }

        let viewModel = CharacterListCellViewModel(character: characters[indexPath.row])
        characterCell.setup(with: viewModel)
//        viewModel.loadImage(for: characterCell, at: indexPath.row)
        return cell
    }
}
