//
//  ViewController.swift
//  QuickReturn
//
//  Created by aryaman mittal on 11/10/23.
//

import UIKit
import Alamofire
class ViewController: UIViewController ,UITableViewDataSource,UISearchBarDelegate{
    
    @IBOutlet weak var issuedBooksTable: UITableView!
    var bookCat:[BookCategory] = []
    var allbook:[Allbook]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let searchBar = UISearchBar()
               searchBar.delegate = self
               searchBar.placeholder = "Search Books"
               navigationItem.titleView = searchBar
        
        getIssuedBooks()
        issuedBooksTable.dataSource = self
        //issuedBooksTable.delegate = self
        let nib  = UINib(nibName: "issuedCell", bundle: nil)
        issuedBooksTable.register(nib, forCellReuseIdentifier: "issue_cell")
    }
    override func viewDidAppear(_ animated: Bool) {
        getIssuedBooks()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookCat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:issuedCell = issuedBooksTable.dequeueReusableCell(withIdentifier: "issue_cell" ,for: indexPath) as! issuedCell
       cell.indexPth = indexPath
        cell.issCon = self
        if let issueDate=formattingTimeZone(dateString: allbook[indexPath.row].issueDate){
            cell.IssueDateLabel.text! = "Issued On: " + issueDate
        }
        if let returnDate = formattingTimeZone(dateString: allbook[indexPath.row].deadline){
            
            cell.returnLabel.text! = "Return by : " + returnDate
            
            cell.daysLeftLabel.text! = "Days left - \(daysBetweenCurrentDateAndDateString(dateString: returnDate)!)"
        }
        cell.bookLabel.text! = bookCat[indexPath.row].name
        
        return cell
    }
    func daysBetweenCurrentDateAndDateString(dateString: String) -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        if let dateFromString = dateFormatter.date(from: dateString) {
            let currentDate = Date()
            let calendar = Calendar.current
            let components = calendar.dateComponents([.day], from: currentDate, to: dateFromString)
            return components.day
        }
        
        return nil // Return nil if parsing the date fails
    }

    func formattingTimeZone(dateString: String) -> String?{
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        inputDateFormatter.timeZone = TimeZone(identifier: "Asia/Kolkata")
        if let date = inputDateFormatter.date(from: dateString) {
            // Create a DateFormatter for formatting the date in "dd/MM/yyyy" format
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "dd/MM/yyyy"
            
            let formattedDate = outputDateFormatter.string(from: date)
            
            return (formattedDate) // Output: "12/10/2023"
        } else {
            return nil
        }
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let query = searchBar.text, !query.isEmpty {
            let searchResultsViewController : SearchResultsViewController =  self.storyboard?.instantiateViewController(identifier: "SearchResultsViewController") as! SearchResultsViewController
            searchResultsViewController.searchQuery = query
            navigationController?.pushViewController(searchResultsViewController, animated: true)
            searchBar.resignFirstResponder() // Dismiss the keyboard
        }
    }
    

    func getIssuedBooks(){
     
            let strURL:String = "https://arcanists-04-3jz1.onrender.com/api/v1/getissuedbooks"
            AF.request(strURL, method: .get).response {
                (responseObj:AFDataResponse<Data?>)
                in
                if(responseObj.data != nil){
                    do{
    //                self.photosArray = try! JSONDecoder().decode([Photo].self, from: responseObj.data!)
    //
    //                    print(self.photosArray)
                        guard let data = responseObj.data else {
                            print(String(describing: responseObj.error))
                            return
                          }
                        let allBooksData = try JSONDecoder().decode(IssuedBooks.self, from: data)
                        print(allBooksData)
                        if(allBooksData.success){
                            self.bookCat = allBooksData.bookCategories
                            self.allbook = allBooksData.allBooks
                        }
                        DispatchQueue.main.async {
                            self.issuedBooksTable.reloadData()
                        }
                    }
                    catch{
                            print("Error in json parsing ", error)
                        
                    }
                }
            
            }
        }
    


}

