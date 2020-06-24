import Foundation
import UIKit

class ItemListTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: ItemListTableViewCell.self)
    
    static let heightRow = CGFloat(100)
    
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var descriptionLabel: UILabel?
    @IBOutlet weak var lastUpdatedLabel: UILabel?
    
    var repository: Repository?

    func configureCell(repository: Repository) {
        descriptionLabel?.text = repository.description
        nameLabel?.text = repository.name
        lastUpdatedLabel?.text = repository.updatedAt
    }
}

