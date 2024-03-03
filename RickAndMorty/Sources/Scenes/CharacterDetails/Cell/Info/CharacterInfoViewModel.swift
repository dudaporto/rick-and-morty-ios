import class UIKit.UIImage

protocol CharacterAboutSectionConfigProtocol {
    var icon: UIImage { get }
    var title: String { get }
    var hideSeparatorView: Bool { get }
}

struct CharacterInfoViewModel {
    let aboutSectionConfig: CharacterAboutSectionConfigProtocol
    let description: String
}

struct SpeciesSectionConfig: CharacterAboutSectionConfigProtocol {
    var icon: UIImage { Image.iconSpecie.image }
    var title: String { Strings.CharacterDetails.specie }
    var hideSeparatorView: Bool { false }
}

struct OriginSectionConfig: CharacterAboutSectionConfigProtocol {
    var icon: UIImage { Image.iconOrigin.image }
    var title: String { Strings.CharacterDetails.origin }
    var hideSeparatorView: Bool { false }
}

struct GenderSectionConfig: CharacterAboutSectionConfigProtocol {
    var icon: UIImage { Image.iconPerson.image }
    var title: String { Strings.CharacterDetails.gender }
    var hideSeparatorView: Bool { true }
}
