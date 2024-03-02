// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CharacterListQuery: GraphQLQuery {
  public static let operationName: String = "CharacterList"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query CharacterList($page: Int, $search: String) { characters(page: $page, filter: { name: $search }) { __typename info { __typename next } results { __typename name image location { __typename name } status } } }"#
    ))

  public var page: GraphQLNullable<Int>
  public var search: GraphQLNullable<String>

  public init(
    page: GraphQLNullable<Int>,
    search: GraphQLNullable<String>
  ) {
    self.page = page
    self.search = search
  }

  public var __variables: Variables? { [
    "page": page,
    "search": search
  ] }

  public struct Data: RickAndMortyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("characters", Characters?.self, arguments: [
        "page": .variable("page"),
        "filter": ["name": .variable("search")]
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
        .field("info", Info?.self),
        .field("results", [Result?]?.self),
      ] }

      public var info: Info? { __data["info"] }
      public var results: [Result?]? { __data["results"] }

      /// Characters.Info
      ///
      /// Parent Type: `Info`
      public struct Info: RickAndMortyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Info }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("next", Int?.self),
        ] }

        /// Number of the next page (if it exists)
        public var next: Int? { __data["next"] }
      }

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
          .field("image", String?.self),
          .field("location", Location?.self),
          .field("status", String?.self),
        ] }

        /// The name of the character.
        public var name: String? { __data["name"] }
        /// Link to the character's image.
        /// All images are 300x300px and most are medium shots or portraits since they are intended to be used as avatars.
        public var image: String? { __data["image"] }
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
