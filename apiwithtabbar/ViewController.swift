//
//  ViewController.swift
//  apiwithtabbar
//
//  Created by rajanOS on 07/03/22.
//

import UIKit
import Alamofire
import SwiftyJSON
import JGProgressHUD

//private let spinner = JGProgressHUD(style: .dark)
class ViewController: UIViewController {
    private let spinner = JGProgressHUD(style: .dark)
//    private var hasFeched = false
    @IBOutlet weak var searchbar: UISearchBar!
    //
//    private let searchBar : UISearchBar = {
//       let searchBar = UISearchBar()
//        searchBar.placeholder = "SEarch for users"
//        return searchBar
//    }()
    
  //  @IBOutlet weak var collview: UICollectionView!
//    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    //    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
//    let segmentedControl: UISegmentedControl = {
//        let sc = UISegmentedControl(items: ["temperature", "last update","a-z"])
//        return sc
//    }()
    
    @IBOutlet weak var mytable: UITableView!
    
    var descriptionList = [[String:Any]]()
    
    var searchResults = [String]()
    var searching = false
    var newList: [SubCategories] = []
    var filteredData = [[String]]()
    var descriptionListing = [DescriptionListing]()
    private var initialArray: [String] = []
//    var epocTime = TimeInterval(1429162809359)/1000

 //   var resultSearchController = UISearchController()
    override func viewDidLoad() {
        super.viewDidLoad()
  //      filteredData = newList
        searchbar.delegate = self
        let nib = UINib(nibName: "TableViewCell1", bundle: nil)
        mytable.register(nib, forCellReuseIdentifier: "cell")
        
        self.sortTable()
   getData()
        
    //    let searchTextField = self.searchbar.searchTextField
            //// searchTextField.textColor = UIColor.white
             // searchTextField.clearButtonMode = .never
            //  searchTextField.backgroundColor = UIColor.black
        self.searchbar.showsCancelButton = true
   //     navigationController?.navigationBar.topItem?.titleView = searchBar
    //    searchBar.becomeFirstResponder()
//        let myDate = NSDate(timeIntervalSince1970: epocTime)
//        print("Converted Time \(myDate)")
//        let stackView = UIStackView(arrangedSubviews: [
//        segmentedControl,collview
//
//
//        ]
//
//        )
//        stackView.axis = .vertical
//        view.addSubview(stackView)
//
      //  stackView.anchor(top: view.topAnchor)
        // Do any additional setup after loading the view.
    }
    
    
//    func getSortedObjs() -> [SubCategories] {
//        if segmentcustomtable == SortState.name {
//            return newList.sorted { $0.name < $1.name}
//        } else {
//            return newList.sorted { $0.lastupdate < $1.lastupdate}
//        }
//    }

    func sortTable() {
        switch segmentedControl.selectedSegmentIndex
           {
           case 0:
            spinner.show(in: view)
          //  print(newList)
//
//            let students: Set = newList[<#Int#>].weatherTemp
             newList.sort(by: { $0.weatherTemp > $1.weatherTemp })
           print(newList)
//             newList.append(contentsOf: descendingStudents)
//            print(descendingStudents)
            mytable.reloadData()
            spinner.dismiss(animated: true)
          //  let numbers = newList[0].weatherTemp > newList[1].weatherTemp
      //      _ = Array(numbers.sorted( by: { $0>$1 } ))
            print(1)
           //    newList = "First Segment Selected"
           case 1:
            
            spinner.show(in: view)
          //  let epocTime = TimeInterval(1429162809359)/1000
            
         //   let myDate = NSDate(timeIntervalSince1970: epocTime)
         //   print("Converted Time \(myDate)")
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "HH:MM a dd mmm yyyy"
            newList.sort(by: { $0.lastupdate! > $1.lastupdate!})
//            let epoctime = TimeInterval("lastupdate")!/1000
           // print(convertDate(dateValue: ))
            mytable.reloadData()
            
            print("2")
            spinner.dismiss(animated: true)
             //  newList = "Second Segment Selected"
          case 2:
            spinner.show(in: view)
           mytable.reloadData()
            
            newList.sort(by: { $0.name < $1.name })
            
            
      print("3")
            spinner.show(in: view)
            spinner.dismiss(animated: true)
         // newList = "Second Segment Selected"
           default:
               break
              ///    default:
                //    <#code#>
       //           }
       
        }
        mytable.reloadData()
        spinner.dismiss(animated: true)
    }
    
    
    @IBAction func segmentcustomtable(_ sender: UISegmentedControl)  {
        
        sortTable()
     //   mytable.reloadData()
//        switch segmentedControl.selectedSegmentIndex
//           {
//           case 0:
//
//          //  print(newList)
////
////            let students: Set = newList[<#Int#>].weatherTemp
//            let descendingStudents = newList.sorted(by: { $0.weatherTemp > $1.weatherTemp })
//
//             newList.append(contentsOf: descendingStudents)
//            print(descendingStudents)
//        //    mytable.reloadData()
//          //  let numbers = newList[0].weatherTemp > newList[1].weatherTemp
//      //      _ = Array(numbers.sorted( by: { $0>$1 } ))
//            print(1)
//           //    newList = "First Segment Selected"
//           case 1:
//         //   mytable.reloadData()
//
//            print("2")
//             //  newList = "Second Segment Selected"
//          case 2:
//     //       mytable.reloadData()
//      print("3")
//         // newList = "Second Segment Selected"
//           default:
//               break
//              ///    default:
//                //    <#code#>
//       //           }
//
//        }
//        mytable.reloadData()
    }
//}
//    func convertDate(dateValue: Int) -> String {
//        let truncatedTime = Int(dateValue / 1000)
//        let date = Date(timeIntervalSince1970: TimeInterval(truncatedTime))
//        let formatter = DateFormatter()
//        formatter.timeZone = TimeZone(abbreviation: "UTC")
//        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
//        return formatter.string(from: date)
//    }
    
    func getData(){
        let urlFile = "http://www.keshavinfotechdemo.com/KESHAV/UPDATE/07/iphone/Trainee/weather.json"
        
        
        Alamofire.request(urlFile).responseJSON{ [self]
            (response) in
         //
            //print(response)
            print("sucessfully")
            switch response.result {
            case .success(_):
                
                let jsondata = (response.result.value as! [String : AnyObject])["data"] as!
                [[String : Any]]
                
                
          //      import UIKit
             //   let htmlString = "<html><body> Some <b>html</b> string </body></html>"
                // works even without <html><body> </body></html> tags, BTW
//                let data = htmlString.data(using: String.Encoding.unicode)! // mind "!"
//                let attrStr = try? NSAttributedString( // do catch
//                    data: data,
//                    options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
//                    documentAttributes: nil)
                // suppose we have an UILabel, but any element with NSAttributedString will do
             //   label.attributedText = attrStr
                
                
                
//                do {
//                    let attrStr = try! NSAttributedString(
//                        data: "responseData".data(using: String.Encoding.unicode, allowLossyConversion: true)!,
//                        options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
//                        documentAttributes: nil)
//                   // label.attributedText = attrStr
//                } catch let error {
//
//                }
                
               // let jsonData = try JSONEncoder().encode(sentences)
           
                
        //        let jsonString = String(data: jsondata, encoding: .utf8)!
          
                
           //     print(jsondata)
             
                
                var list: [SubCategories] = []
//
               for category in jsondata {
                   
                    let categoryData = SubCategories(
                        name: (category["_name"] as? String) ?? "",
                        
                        weatherCondition: (category["_weatherCondition"] as? String) ?? "",
                        
                        weatherTemp: (category["_weatherTemp"] as? String) ?? "",
                        
                        lastupdate: (category["_weatherLastUpdated"] as? Int) ?? 0
                        
                      //  country: (category["_country"] as? [String]) ?? ["","",""]
                
                       
                    )
                   spinner.show(in: view)
                   list.append(categoryData)
               }
//
           //   print(list)

                self.newList = list
                
//                //response.result.value as! [[String:Any]]
            
                self.descriptionList = jsondata
                self.mytable.reloadData()
                spinner.dismiss(animated: true)
            case .failure(_):
                print("errror")
            }
        }
 
    }
}
//extension ViewController: UISearchBarDelegate {
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//       filteredData = []
//        for name in newList {
//            if name.contains(searchText){
//                filteredData.append(word)
//            }
//        }
//        print("hello")
//    }
//}
extension ViewController : UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        let text: String = self.searchbar.text ?? ""
//        self.newList = []
//        for item in self.initialArray {
//            if (item.lowercased().contains(text.lowercased())) {
//            self.newList.append()
//                print(SubCategories.init(name: "", weatherCondition: "", weatherTemp: "", lastupdate:))
//            }
//        }
//        if (text.isEmpty) {
//
//            print("err")
//            mytable.reloadData()
//            //    self.newList as? String = self.initialArray
//        }
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//           // When there is no text, filteredData is the same as the original data
//           // When user has entered text into the search box
//           // Use the filter method to iterate over all items in the data array
//           // For each item, return true if the item should be included and false if the
//           // item should NOT be included
//        filteredData = searchText.isEmpty ? newList : newList.filter { ($0.newList : String) -> Bool in
//               // If dataItem matches the searchText, return true to include it
//               return filteredData.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
//           }
//
//           mytable.reloadData()
//       }
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//        searchBar.resignFirstResponder()
//        if let name = searchBar.text {
//
//            print(name)
//            mytable.reloadData()
//            getData()
//        }
    }
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//            searchResults = filteredData.filter { $0 == searchText }
//            searching = true
//            mytable.reloadData()
//        }
////
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//            searching = false
//            searchBar.text = ""
//            mytable.reloadData()
//        }
    
    
//}
extension ViewController: UITableViewDelegate,UITableViewDataSource {
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if searching {
////            print("\(filteredData)")
////
////            return filteredData.count
////
//        }
            //else{
            return newList.count
       // }
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mytable.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell1
//        if searching {
//            cell.lbl1.text = newList[indexPath.row].name
//        }else{
        let x = newList[indexPath.row].lastupdate
             if let xx = x {
                 let epocTime = TimeInterval(xx)
                 let xx = Date(timeIntervalSince1970: epocTime)
//                 let formatter2 = DateFormatter()
//                 formatter2.timeStyle = .medium
//
//
//                 print(formatter2.string(from: xx))
//
                 let formatter3 = DateFormatter()
                 formatter3.dateFormat = "HH:mm a  d MMM y"
               //  print(formatter3.string(from: xx))

                 
//                let dateFormatter = DateFormatter()
//                 dateFormatter.dateFormat = "MMM d, h:mm a"
//                 dateFormatter.timeZone = NSTimeZone(name: "UTC")
//                 let dateStr = "\(xx)"
//                 let date = dateFormatter.date(from: dateStr)
                 // Jan 20, 2020 at 12:00 AM
                 
//                 let formatter = DateFormatter()
//                 formatter.timeZone = TimeZone(abbreviation: "UTC")
//                 formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
              //   return formatter.string(from: epocTime)
                 //let epocTime = TimeInterval(1429162809359)/1000
                  
              //    let myDate = NSDate(timeIntervalSince1970: epocTime)
               //   print("\(xx)")
                 self.searchbar.searchTextField.endEditing(true)
// print(dateFormatter)
               // print(formatter2)
//print(xx)
                 cell.lbl3.text = "\(formatter3.string(from: xx))"
             } else {
                 cell.lbl3.text = "\(x)"
             }
  //      spinner.show(in: view)
        cell.lbl1.text = newList[indexPath.row].name
        cell.lbl2.text = newList[indexPath.row].weatherCondition
        
    //    cell.lbl3.text = "\(newList[indexPath.row].lastupdate)"
        cell.lbl4.text = newList[indexPath.row].weatherTemp
    
      //  }
        
        
        return cell
    }
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//      //  newList = []
//        descriptionListing = []
//
//        for name in newList {
//            if name.contains(searchText) {
//                descriptionListing.append(name)
//        }
//    }
}


//extension ViewController: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        guard let text = searchBar.text, !text.replacingOccurrences(of: " ", with: " ").isEmpty else {
//            return
//        }
//        searchBar.resignFirstResponder()
//        newList.removeAll()
//        spinner.show(in: view)
//        self.searchUsers(query: text)
//    }
//
//    func searchUsers(query: String){
//        if hasFeched{
//          filterUsers(with: query)
//
//        }else{
////            newList(completion: { [weak self] result in
////                switch result {
////                case .success(let usersCollection):
////                    self?.hasFeched = true
////                    self?.filterUsers(with: query)
////                    self?.users = usersCollection
////                case .failure(let error):
//                    print("feiled to get user: ")
//                }
//
//           // })
//
//
//
//    func filterUsers(with term: String){
//        guard hasFeched else{
//            return
//        }
//    }
//    }
//        self.spinner.dismiss()
//        let newlis : [[String: String]] = self.users.filter({
//
//            guard let name = $0["name"]?.lowercased()  else{
//                return false
//            }
//            return name.hasPrefix(term.lowercased())
//        })
//
//        self.results = results
//        updateUI()
//    }
//    func updateUI() {
//        if results.isEmpty{
//            self.noResultsLabel.isHidden = false
//            self.tableView.isHidden = true
//        }
//        else{
//
//                self.noResultsLabel.isHidden = true
//                self.tableView.isHidden = false
//            self.tableView.reloadData()
//        }
//    }
//}

    
    
    
    
    
    

struct SubCategories {
    let name: String
    let weatherCondition: String
    let weatherTemp : String
    let lastupdate: Int?
 //   let country: [String]
}

