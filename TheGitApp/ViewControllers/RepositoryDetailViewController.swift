import Foundation
import UIKit

class RepositoryDetailViewController: UITableViewController {
    /**
      Un ecran cu detalii ale unui repository care sa afiseze cateva metadate(forkuri, watchers, user, link, etc) si continutul din Readme
     */
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var updatedAtLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    
    @IBOutlet weak var readmeView: UITextView!
    
    var viewModel: RepositoryDetailViewModel?
    var repository: Repository?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = self.viewModel?.repository.name
        
        userLabel.text = self.viewModel?.repository.owner.login
        linkLabel.text = self.viewModel?.repository.htmlUrl
        updatedAtLabel.text = self.viewModel?.repository.updatedAt
        createdAtLabel.text = self.viewModel?.repository.createdAt
        forksLabel.text = String(self.viewModel?.repository.forksCount ?? 0)
        watchersLabel.text = String(self.viewModel?.repository.watchersCount ?? 0)

        setupBind()
        
        viewModel?.fetch()
    }
    
    private func setupBind() {
        viewModel?.resultFetched = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView?.beginUpdates()
                self?.readmeView.attributedText = self?.viewModel?.readmeContent
                self?.tableView?.endUpdates()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
}
