//
//  BAMProjectListViewController.swift
//  BAMProspect
//
//  Created by Nicolas Masson on 06/09/2020.
//  Copyright © 2020 BAM. All rights reserved.
//

import Foundation
import UIKit

class BAMProjectListViewController: UITableViewController {

    var viewModel: ProjectListViewModel!
    //let refreshControl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        viewModel = ProjectListViewModel()
        bind(to: viewModel)
        viewModel.loadFirstPage()

        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
    }

    private func bind(to viewModel: ProjectListViewModel) {
        viewModel.items.observe(on: self) { [weak self] _ in self?.reload() }
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
    }

    func reload() {
        refreshControl?.endRefreshing()
        self.tableView.reloadData()
    }

    func showError(_ error: String) {
        guard error != "" else {
            return
        }
        UserMessage.showError(message: error)
    }

    @objc func onRefresh() {
        viewModel.loadFirstPage()
    }

}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension BAMProjectListViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProjectItemCell.reuseIdentifier, for: indexPath) as? ProjectItemCell else {
            assertionFailure("Cannot dequeue reusable cell \(ProjectItemCell.self) with reuseIdentifier: \(ProjectItemCell.reuseIdentifier)")
            return UITableViewCell()
        }

        cell.fill(with: viewModel.items.value[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if viewModel.hasNextPage, indexPath.row == viewModel.items.value.count - 1 {
            viewModel.loadNextPage()
        }
    }

}


final class ProjectItemCell: UITableViewCell {

    static let reuseIdentifier = String(describing: ProjectItemCell.self)
    static let height = CGFloat(130)

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!

    private var viewModel: ProjectViewModel!

    func fill(with viewModel: ProjectViewModel) {
        self.viewModel = viewModel

        titleLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
    }

    @IBAction func favoriteButtonTapped(_ sender: Any) {
    }
}
