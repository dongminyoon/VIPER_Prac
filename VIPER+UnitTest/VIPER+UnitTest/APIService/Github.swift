//
//  Github.swift
//  VIPER+UnitTest
//
//  Created by USER on 2021/02/10.
//

import Foundation
import Moya

extension String {
    var escapingUrl: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? self
    }
}

enum Github {
    case usersRepo(name: String)
}

extension Github: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .usersRepo(let name): return "/users/\(name.escapingUrl)/repos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .usersRepo: return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .usersRepo: return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
