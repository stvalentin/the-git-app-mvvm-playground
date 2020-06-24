import Foundation
import UIKit

extension UIStoryboard {
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}

extension UIStoryboard {
    var listViewController: RepositoryListViewController {
        guard let viewController = instantiateViewController(withIdentifier: String(describing: RepositoryListViewController.self)) as? RepositoryListViewController else {
            fatalError(String(describing: RepositoryListViewController.self) + "\(NSLocalizedString("couldn't be found in Storyboard file", comment: ""))")
        }

        return viewController
    }
}
