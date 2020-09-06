//
//  GitBackend.swift
//  BAMProspect
//
//  Created by Nicolas Masson on 06/09/2020.
//  Copyright © 2020 BAM. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit

typealias CompletionHandler = (JSON?, NSError?) -> Void
typealias Router = URLRequestConvertible

class GitBackend {
    static let sharedBackend: GitBackend = GitBackend()

    func getProjectList(page: Int, completionHandler: @escaping CompletionHandler) {
        request(GitRouter.getListProject(page: page), completionHandler: completionHandler)
    }

    func request(_ url: Router, completionHandler: @escaping CompletionHandler) {
        request(url)
            .validate()
            .responseJSON { response in
                Self.handleResponse(response, withCompletionHandler: completionHandler)
        }
    }

    func request(_ url: Router) -> DataRequest {
        return Alamofire.request(url)
    }

    static internal func handleResponse(_ response: DataResponse<Any>, withCompletionHandler handler: CompletionHandler?) {
        switch response.result {
        case .failure(let error):
            var value: JSON?
            if let data = response.data {
                value = try? JSON(data: data)
            }
            handler?(value, error as NSError)
        case .success(let value):
            handler?(JSON(value), nil)
        }
    }
}
