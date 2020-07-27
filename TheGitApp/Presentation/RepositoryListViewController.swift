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
    
    private let searchController = { () -> UISearchController in
        let searchController = UISearchController(
            searchResultsController: nil
        )
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = true
//        searchController.searchBar.scopeButtonTitles = [
//            "Repositories",
//            "Commits",
//            "Code",
//            "Topics",
//            "Labels",
//        ]
        searchController.searchBar.sizeToFit()
        return searchController
    }()

    var viewModel: RepositoryListViewModel? {
        didSet {
            setupBind()
        }
    }
        
    weak var delegate: RepositoryListViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext  = true
        self.navigationController?.navigationBar.isTranslucent = true
        searchController.searchResultsUpdater = self
        tableView.tableHeaderView = searchController.searchBar
        
    }
        
    func setupBind() {
        self.viewModel?.items.bind({ items in
            self.tableView.reloadData()
        })
        
        self.viewModel?.error.bind({ error in
            guard let error = error else {
                return
            }
            
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Retry", style: .cancel, handler: { (action) in
                    self.viewModel?.fetch(searchQuery: "Android")
                }))
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
}

extension RepositoryListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.viewModel?.searchText.value = searchController.searchBar.text
    }
}

extension RepositoryListViewController: UISearchBarDelegate, UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsScopeBar = false
        viewModel?.searchText.value = searchBar.text
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension RepositoryListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.items.value?.items.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
                    withIdentifier: "ItemListTableViewCell",
                               for: indexPath) as! ItemListTableViewCell
        
        guard let repository = self.viewModel?.items.value?.items[indexPath.row] else {
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

        guard let repository = self.viewModel?.items.value?.items[indexPath.row] else {
            fatalError("Cannot get item at \(indexPath.row)")
        }
        
        self.delegate?.didSelect(repository: repository)
    }
}

