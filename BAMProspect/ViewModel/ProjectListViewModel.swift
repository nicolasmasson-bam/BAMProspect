//
//  ProjectListViewModel.swift
//  BAMProspect
//
//  Created by Nicolas Masson on 06/09/2020.
//  Copyright © 2020 BAM. All rights reserved.
//

import Foundation

class ProjectListViewModel {
    var items: Observable<[ProjectViewModel]> = Observable([])
    let error: Observable<String> = Observable("")
    private var projects: [Project] = []
    var currentPage: Int = 0
    var hasNextPage: Bool = true
    var isLoading: Bool = false

    init() {
    }

    func loadFirstPage() {
        guard !isLoading else {
            return
        }
        isLoading = true
        GitManager().getProjectList(page: 0) { [weak self] projects, error in
            guard let strongSelf = self else {
                return
            }
            strongSelf.isLoading = false
            if let error = error {
                // TODO to replace with specific error
                strongSelf.error.value = NSLocalizedString("error.generic", comment: "An error occured")
                return
            }
            guard let projects = projects else {
                strongSelf.hasNextPage = false
                return
            }
            strongSelf.currentPage += 1
            strongSelf.projects.removeAll()
            strongSelf.append(projects: projects)

        }
    }

    func loadNextPage() {
        guard hasNextPage, !isLoading else {
            return
        }
        isLoading = true
        GitManager().getProjectList(page: currentPage + 1) { [weak self] projects, error in
            log.debug("will load next page")
            guard let strongSelf = self else {
                return
            }
            strongSelf.isLoading = false
            if let error = error {
                // TODO to replace with specific error
                strongSelf.error.value = NSLocalizedString("error.generic", comment: "An error occured")
                return
            }
            guard let projects = projects, !projects.isEmpty else {
                strongSelf.hasNextPage = false
                return
            }
            strongSelf.currentPage += 1
            strongSelf.append(projects: projects)

        }
    }

    func changeFavorite(index: Int) {
        self.projects[index].isFavorite = !self.projects[index].isFavorite
        if self.projects[index].isFavorite {
            self.projects[index].isFavorite = false
            FavoriteStore.sharedStore.removeFavorite(favoriteId: self.projects[index].id)
        } else {
            self.projects[index].isFavorite = true
            FavoriteStore.sharedStore.addFavorite(favoriteId: self.projects[index].id)
        }
    }

    fileprivate func append(projects: [Project]) {
        self.projects.append(contentsOf: projects)
        items.value = projects.map( { ProjectViewModel(project: $0)})
    }
}
