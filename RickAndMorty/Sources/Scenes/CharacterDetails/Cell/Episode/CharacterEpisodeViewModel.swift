struct CharacterEpisodeViewModel {
    private let episode: CharacterDetailsResponse.Episode
    let hideSeparatorView: Bool
    
    init(episode: CharacterDetailsResponse.Episode, hideSeparatorView: Bool) {
        self.episode = episode
        self.hideSeparatorView = hideSeparatorView
    }
    
    var episodeCode: String {
        episode.code + ":"
    }
    
    var name: String {
        episode.name
    }
}
