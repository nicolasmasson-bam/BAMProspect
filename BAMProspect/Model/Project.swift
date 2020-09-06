//
//  Project.swift
//  BAMProspect
//
//  Created by Nicolas Masson on 06/09/2020.
//  Copyright © 2020 BAM. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Project {
    let id: Int
    let name: String
    let description: String?

    enum Key: String {
        case id
        case name
        case description
    }

    init?(json: JSON) {
        guard
            let id = json[Key.id.rawValue].int,
            let name = json[Key.name.rawValue].string else {
                log.debug("Error project init")
                log.debug("id : \(String(describing: json[Key.id.rawValue].int))")
                log.debug("name : \(String(describing: json[Key.name.rawValue].string))")
                log.debug("description : \(String(describing: json[Key.description.rawValue].string))")
                return nil
        }
        self.id = id
        self.name = name
        self.description = json[Key.description.rawValue].string
        log.debug("Succeed project init")
    }
}
