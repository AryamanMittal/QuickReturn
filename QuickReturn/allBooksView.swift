//
//  allBooksView.swift
//  QuickReturn
//
//  Created by aryaman mittal on 11/10/23.
//

import UIKit
import Alamofire
class allBooksView: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var allBookTableView: UITableView!
    
    var books:[Books] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        let uinib = UINib(nibName: "booksCell", bundle: nil)
        allBookTableView.register(uinib, forCellReuseIdentifier: "booksCell")
        allBookTableView.dataSource = self
        allBookTableView.delegate = self
            }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:booksCell = allBookTableView.dequeueReusableCell(withIdentifier: "booksCell" ,for: indexPath) as! booksCell
        cell.nameBookLabel.text! = books[indexPath.row].name
        cell.authorOfBook.text! = books[indexPath.row].author
        cell.availableButtonAsLabel.titleLabel?.text = "9/10"
        cell.pagesLabel.text! = "Pg.1000"
        cell.descriptionLabel.text! = "Condtions : " + books[indexPath.row].description
        return cell
    }
    override func viewDidAppear(_ animated: Bool) {
        getAllBooks()
    }
    func getAllBooks(){
        let strURL:String = "https://arcanists-04-3jz1.onrender.com/api/v1/getallbooks"
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
                    let booksData = try JSONDecoder().decode(AllBooks.self, from: data)
                    self.books = booksData.data
                    DispatchQueue.main.async {
                        self.allBookTableView.reloadData()
                    }
                }
                catch{
                        print("Error in json parsing ", error)
                    
                }
            }
        
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
