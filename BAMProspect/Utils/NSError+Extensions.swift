//
//  NSError+Extensions.swift
//  BAMProspect
//
//  Created by Nicolas Masson on 06/09/2020.
//  Copyright © 2020 BAM. All rights reserved.
//

import Foundation

let bamErrorDomain = "tech.bam"

enum NetworkErrorCode: Int {
    case invalidRemoteData = 0, // wrong response format
    missingData,
    noData,
    unknownError
}

extension NSError {
    convenience init(code: NetworkErrorCode, userInfo: [String: Any]? = nil) {
        self.init(domain: bamErrorDomain, code: code.rawValue, userInfo: userInfo)
    }
}
