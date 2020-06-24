//
//  ListViewController.swift
//  TheGitApp
//
//  Created by Stanciu Valentin on 17/06/2020.
//  Copyright © 2020 Stanciu Valentin. All rights reserved.
//

import Foundation
import UIKit

class RepositoryListViewController: UITableViewController {

    var viewModel: RepositoryListViewModel?
    weak var delegate: RepositoryListViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBind()
        viewModel?.fetch(searchQuery: "Android")
    }
    
    func setupBind() {
        viewModel?.resultFetched = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

///
extension RepositoryListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.numberOfItems ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
                    withIdentifier: "ItemListTableViewCell",
                               for: indexPath) as! ItemListTableViewCell
        
        guard let repository = self.viewModel?.list[indexPath.row] else {
            fatalError("Cannot get item at \(indexPath.row)")
        }

        cell.configureCell(repository: repository)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ItemListTableViewCell.heightRow
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           tableView.deselectRow(at: indexPath, animated: false)

        guard let repository = self.viewModel?.list[indexPath.row] else {
            fatalError("Cannot get item at \(indexPath.row)")
        }
        
        self.delegate?.didSelect(repository: repository)
    }
}

