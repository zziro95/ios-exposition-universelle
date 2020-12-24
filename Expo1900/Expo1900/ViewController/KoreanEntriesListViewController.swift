import UIKit

class KoreanEntriesListViewController: UITableViewController {
    
    var koreanEntries: [KoreanEntries] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        decodeJSONFile()
        self.tableView.reloadData()
    }
    
    func decodeJSONFile() {
        let jsonDecoder: JSONDecoder = JSONDecoder()
        let dataAssetName: String = "items"
        guard let dataAsset: NSDataAsset = NSDataAsset.init(name: dataAssetName) else {
            return
        }
        
        do {
            self.koreanEntries = try jsonDecoder.decode([KoreanEntries].self, from: dataAsset.data)
        } catch DecodingError.dataCorrupted(let context) {
            print("데이터가 손상되었거나 유효하지 않습니다.")
            print(context.codingPath, context.debugDescription, context.underlyingError ?? "" , separator: "\n")
        } catch DecodingError.keyNotFound(let codingkey, let context) {
            print("주어진 키를 찾을수 없습니다.")
            print(codingkey.intValue ?? Optional(nil)! , codingkey.stringValue , context.codingPath, context.debugDescription, context.underlyingError ?? "" , separator: "\n")
        } catch DecodingError.typeMismatch(let type, let context) {
            print("주어진 타입과 일치하지 않습니다.")
            print(type.self , context.codingPath, context.debugDescription, context.underlyingError ?? "" , separator: "\n")
        } catch DecodingError.valueNotFound(let type, let context) {
            print("예상하지 않은 null 값이 발견되었습니다.")
            print(type.self , context.codingPath, context.debugDescription, context.underlyingError ?? "" , separator: "\n")
        } catch {
            print("그외 에러가 발생했습니다.")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.koreanEntries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {//UITableViewCell KoreanEntriesDynamicTableViewCell
        let cell: KoreanEntriesDynamicTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! KoreanEntriesDynamicTableViewCell
        
        let entry: KoreanEntries = self.koreanEntries[indexPath.row]
        
        cell.testImageView.image = entry.image
        cell.nameTextLabel.text = entry.name
        cell.shortDescriptionTextLabel.text = entry.shortDescriptions
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = UITableView.automaticDimension
        
        return height
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let koreanEntryViewController = storyboard?.instantiateViewController(identifier: "KoreanEntryViewController") as? KoreanEntryViewController else {
            print("해당 뷰 컨트롤러가 없습니다.")
            return
        }

        let selectedEntry: KoreanEntries = self.koreanEntries[indexPath.row]
        
        koreanEntryViewController.fetchData = selectedEntry

        navigationController?.pushViewController(koreanEntryViewController, animated: true)
    }
}
