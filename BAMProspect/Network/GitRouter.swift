//
//  GitRouter.swift
//  BAMProspect
//
//  Created by Nicolas Masson on 06/09/2020.
//  Copyright © 2020 BAM. All rights reserved.
//

import Foundation
import Alamofire

enum GitRouter: URLRequestConvertible {
    static let baseURLString = "https://api.github.com/orgs/bamlab/"

    case getListProject(page: Int)

    var method: HTTPMethod {
        switch self {
        case .getListProject:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getListProject(let page):
            return "repos?page=\(page)"
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url: URL = URL(string: GitRouter.baseURLString + path)!
        var urlRequest = URLRequest(url: url)
        log.debug("url  : \(urlRequest.url)")
        urlRequest.httpMethod = method.rawValue
        //urlRequest = setHeaderFields(urlRequest)
        //log.debug("url : \(String(describing: urlRequest.url))")
        return urlRequest
    }
}
