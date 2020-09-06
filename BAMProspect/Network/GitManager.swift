//
//  GitManager.swift
//  BAMProspect
//
//  Created by Nicolas Masson on 06/09/2020.
//  Copyright © 2020 BAM. All rights reserved.
//

import Foundation
import SwiftyJSON

class GitManager {

    func getProjectList(page: Int, completionHandler: @escaping ([Project]?, NSError?) -> Void) {
        GitBackend.sharedBackend.getProjectList(page: page) { value, error in
            if let error = error {
                completionHandler(nil, error)
                return
            }
            guard let values = value?.array else {
                // No error from server but wrong response format
                let error = NSError(code: .invalidRemoteData)
                completionHandler(nil, error)
                return
            }
            let projectList = values.compactMap({ Project(json: $0) })
            completionHandler(projectList, nil)
        }
    }
}
