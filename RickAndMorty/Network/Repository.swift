import Apollo
import ApolloAPI
import Foundation

enum NetworkError: Error {
    case invalidURL
    case dataError
    case serverError
}

protocol RepositoryProtocol {
    func fetch<T: GraphQLQuery>(query: T, completion: @escaping (Result<T.Data, NetworkError>) -> Void)
}

final class Repository: RepositoryProtocol {
    private let apiPath = "https://rickandmortyapi.com/graphql"
    
    private(set) lazy var apollo: ApolloClient? = {
       guard let url = URL(string: apiPath) else {
           return nil
       }
       return ApolloClient(url: url)
   }()
    
    func fetch<T: GraphQLQuery>(query: T, completion: @escaping (Result<T.Data, NetworkError>) -> Void) {
        guard let apollo else {
            completion(.failure(.invalidURL))
            return
        }
        
        apollo.fetch(query: query) { result in
            switch result {
            case .success(let response):
                guard let data = response.data else {
                    completion(.failure(.dataError))
                    return
                }
                completion(.success(data))
            case .failure:
                completion(.failure(.serverError))
            }
        }
    }
}
