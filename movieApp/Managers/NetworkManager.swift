//
//  networkService.swift
//  movieApp
//
//  Created by Berk Çiçekler on 24.12.2024.
//


import Alamofire
import Foundation

struct NetworkConfig {
    let baseUrl: String
}

enum NetworkPath {
    case genres
    case nowPlaying
    case upComing
    case topRated
    case popular
    case movieDetails(id: Int)
    case movieCredits(id: Int)
    case movieReviews(id: Int)
    case searchMovie
    
    static let baseUrlReqres: String = "https://api.themoviedb.org/"
    
    var path: String {
        switch self {
        case .genres:
            return "3/genre/movie/list"
        case .nowPlaying:
            return "3/movie/now_playing"
        case .upComing:
            return "3/movie/upcoming"
        case .topRated:
            return "3/movie/top_rated"
        case .popular:
            return "3/movie/popular"
        case .movieDetails(let id):
            return "3/movie/\(id)"
        case .movieCredits(let id):
            return "3/movie/\(id)/credits"
        case .movieReviews(let id ):
            return "3/movie/\(id)/reviews"
        case .searchMovie:
            return "3/search/movie"
        }
    }
}

protocol INetworkManager {
    func fetch<T: Codable>(path: NetworkPath, method: HTTPMethod, type: T.Type, queryParameters: [String: Any]?) async -> T?
    var config: NetworkConfig { get set }
}

class NetworkManager: INetworkManager {
    internal var config: NetworkConfig
    
    static let shared = NetworkManager(config: NetworkConfig(baseUrl: NetworkPath.baseUrlReqres))
    
    private let apiKey: String = ""

    private init(config: NetworkConfig) {
        self.config = config
    }

    func fetch<T: Codable>(path: NetworkPath, method: HTTPMethod, type: T.Type, queryParameters: [String: Any]? = nil) async -> T? {
        let dataRequest = AF.request("\(config.baseUrl)\(path.path)", method: method, parameters: queryParameters, headers: [
            "Authorization": "Bearer \(apiKey)"
        ])
            .validate()
            .serializingDecodable(T.self)

        let result = await dataRequest.response
        
        guard let value = result.value else {
            print("ERROR: \(String(describing: result.error))")
            return nil
        }

        return value
    }
}
