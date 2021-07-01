import UIKit

class KoreanEntriesDynamicTableViewCell: UITableViewCell {

    @IBOutlet weak var koreanEntriyImageView: UIImageView!
    @IBOutlet weak var nameTextLabel: UILabel!
    @IBOutlet weak var shortDescriptionTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
