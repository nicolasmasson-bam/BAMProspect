//
//  ProjectViewModel.swift
//  BAMProspect
//
//  Created by Nicolas Masson on 06/09/2020.
//  Copyright © 2020 BAM. All rights reserved.
//

import Foundation

struct ProjectViewModel: Equatable {
    let name: String
    let description: String
    var isFavorite: Bool
}

extension ProjectViewModel {

    init(project: Project) {
        self.name = project.name
        self.description = project.description ?? NSLocalizedString("project.noDescription",
                                                                    comment: "No description")
        self.isFavorite = false
    }
}
