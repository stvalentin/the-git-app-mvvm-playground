import Foundation
import UIKit

class AppCoordinator {
    private var window: UIWindow
    private var navigationController: UINavigationController
    private var repositoryListCoordinator: RepositoryListCoordinator?
    private var apiClient: ApiProtocol
    
    init(window: UIWindow, navigationController: UINavigationController, apiClient: ApiProtocol) {
        self.window = window
        self.navigationController = navigationController
        self.apiClient = apiClient
        self.navigationController.navigationBar.topItem?.title = "Back"
    }
    
    func start() {
        self.repositoryListCoordinator = RepositoryListCoordinator(navigator: navigationController, apiClient: apiClient)

        window.rootViewController = navigationController
        
        self.repositoryListCoordinator?.start()
        window.makeKeyAndVisible()
    }
}
