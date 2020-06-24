import UIKit

class RepositoryDetailCoordinator: Coordinator {
        
    private let navigator: UINavigationController
    private var repositoryDetailViewController: RepositoryDetailViewController?
    private let viewModel: RepositoryDetailViewModel
    
    init(navigator: UINavigationController, viewModel: RepositoryDetailViewModel) {
        self.navigator = navigator
        self.viewModel = viewModel
    }
    
    public func start() {
        let repositoryDetailViewController = UIStoryboard.main.instantiateViewController(identifier: "DetailViewController") as RepositoryDetailViewController
        
        repositoryDetailViewController.viewModel = viewModel
        self.repositoryDetailViewController = repositoryDetailViewController

        navigator.pushViewController(repositoryDetailViewController, animated: true)
    }
}
