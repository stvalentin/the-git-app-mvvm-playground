import Foundation
import UIKit


protocol RepositoryListViewControllerDelegate: class {
    func didSelect(repository: Repository)
}

class RepositoryListCoordinator: Coordinator {
    
    private var navigator: UINavigationController
    fileprivate var apiClient: ApiProtocol
    private var repositoryListViewController: RepositoryListViewController?
    
    init(navigator: UINavigationController, apiClient: ApiProtocol) {
        self.navigator = navigator
        self.apiClient = apiClient
    }
    
    func start() {

        let viewModel = RepositoryListViewModel(apiClient: self.apiClient)
        let repositoryListViewController = UIStoryboard.main.instantiateViewController(identifier: "RepositoryListViewController") as RepositoryListViewController
        repositoryListViewController.viewModel = viewModel
        repositoryListViewController.delegate = self

        navigator.pushViewController(repositoryListViewController, animated: true)
        self.repositoryListViewController = repositoryListViewController
    }
}


/// MARK - RepositoryListCoordinator
extension RepositoryListCoordinator: RepositoryListViewControllerDelegate {
    func didSelect(repository: Repository) {

        let viewModel = RepositoryDetailViewModel(apiClient: self.apiClient, repository: repository)
        let repositoryDetailViewCoordinator = RepositoryDetailCoordinator(
            navigator: self.navigator,
            viewModel: viewModel
        );

        coordinate(to: repositoryDetailViewCoordinator)
    }
}
