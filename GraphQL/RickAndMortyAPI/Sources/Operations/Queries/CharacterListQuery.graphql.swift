// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CharacterListQuery: GraphQLQuery {
  public static let operationName: String = "CharacterList"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query CharacterList { characters(page: 1, filter: { name: "" }) { __typename results { __typename name location { __typename name } status } } }"#
    ))

  public init() {}

  public struct Data: RickAndMortyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("characters", Characters?.self, arguments: [
        "page": 1,
        "filter": ["name": ""]
      ]),
    ] }

    /// Get the list of all characters
    public var characters: Characters? { __data["characters"] }

    /// Characters
    ///
    /// Parent Type: `Characters`
    public struct Characters: RickAndMortyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Characters }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("results", [Result?]?.self),
      ] }

      public var results: [Result?]? { __data["results"] }

      /// Characters.Result
      ///
      /// Parent Type: `Character`
      public struct Result: RickAndMortyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Character }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("name", String?.self),
          .field("location", Location?.self),
          .field("status", String?.self),
        ] }

        /// The name of the character.
        public var name: String? { __data["name"] }
        /// The character's last known location
        public var location: Location? { __data["location"] }
        /// The status of the character ('Alive', 'Dead' or 'unknown').
        public var status: String? { __data["status"] }

        /// Characters.Result.Location
        ///
        /// Parent Type: `Location`
        public struct Location: RickAndMortyAPI.SelectionSet {
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
      }
    }
  }
}
