import UIKit

final class CharacterDetailsAdapter: NSObject, UITableViewDataSource {
    enum Section: Int, CaseIterable {
        case about
        case episodes
    }
    
    private enum AboutSection: Int, CaseIterable {
        case species
        case origin
        case gender
    }
    
    var character: CharacterDetailsResponse?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let character,
              let section = Section(rawValue: section) else { return 0 }
        
        switch section {
        case .about:
            return AboutSection.allCases.count
        case .episodes:
            return character.episodes.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .about:
            return aboutCell(for: indexPath.row)
        case .episodes:
            return episodeCell(for: indexPath.row)
        }
    }
}

private extension CharacterDetailsAdapter {
    func aboutCell(for row: Int) -> UITableViewCell {
        guard let character,
              let aboutSection = AboutSection(rawValue: row) else { return UITableViewCell() }
        
        let viewModel: CharacterInfoViewModel
        switch aboutSection {
        case .species:
            viewModel = .init(aboutSectionConfig: SpeciesSectionConfig(), description: character.species.capitalized)
        case .origin:
            viewModel = .init(aboutSectionConfig: OriginSectionConfig(), description: character.origin.capitalized)
        case .gender:
            viewModel = .init(aboutSectionConfig: GenderSectionConfig(), description: character.gender.rawValue.capitalized)
        }
        
        let aboutCell = CharacterInfoCell()
        aboutCell.setup(viewModel: viewModel)
        return aboutCell
    }
    
    func episodeCell(for row: Int) -> UITableViewCell {
        guard let character, character.episodes.indices.contains(row) else { return UITableViewCell() }
        
        let episode = character.episodes[row]
        let isLast = row == character.episodes.count - 1
        let viewModel = CharacterEpisodeViewModel(episode: episode, hideSeparatorView: isLast)
        let cell = CharacterEpisodeCell(style: .default, reuseIdentifier: CharacterEpisodeCell.identifier)
        cell.setup(viewModel: viewModel)
        return cell
    }
}
