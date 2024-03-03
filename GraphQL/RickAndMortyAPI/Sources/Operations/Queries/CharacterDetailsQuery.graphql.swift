// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CharacterDetailsQuery: GraphQLQuery {
  public static let operationName: String = "CharacterDetails"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query CharacterDetails($id: ID!) { character(id: $id) { __typename species gender origin { __typename name } episode { __typename name episode } } }"#
    ))

  public var id: ID

  public init(id: ID) {
    self.id = id
  }

  public var __variables: Variables? { ["id": id] }

  public struct Data: RickAndMortyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("character", Character?.self, arguments: ["id": .variable("id")]),
    ] }

    /// Get a specific character by ID
    public var character: Character? { __data["character"] }

    /// Character
    ///
    /// Parent Type: `Character`
    public struct Character: RickAndMortyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Character }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("species", String?.self),
        .field("gender", String?.self),
        .field("origin", Origin?.self),
        .field("episode", [Episode?].self),
      ] }

      /// The species of the character.
      public var species: String? { __data["species"] }
      /// The gender of the character ('Female', 'Male', 'Genderless' or 'unknown').
      public var gender: String? { __data["gender"] }
      /// The character's origin location
      public var origin: Origin? { __data["origin"] }
      /// Episodes in which this character appeared.
      public var episode: [Episode?] { __data["episode"] }

      /// Character.Origin
      ///
      /// Parent Type: `Location`
      public struct Origin: RickAndMortyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Location }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("name", String?.self),
        ] }

        /// The name of the location.
        public var name: String? { __data["name"] }
      }

      /// Character.Episode
      ///
      /// Parent Type: `Episode`
      public struct Episode: RickAndMortyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Episode }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("name", String?.self),
          .field("episode", String?.self),
        ] }

        /// The name of the episode.
        public var name: String? { __data["name"] }
        /// The code of the episode.
        public var episode: String? { __data["episode"] }
      }
    }
  }
}
