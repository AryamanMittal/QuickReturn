//
//  SearchResultsViewController.swift
//  QuickReturn
//
//  Created by aryaman mittal on 11/10/23.
//

import UIKit

class SearchResultsViewController: UIViewController{
    var searchQuery: String = ""
    
        //var searchResults: [Book] // Replace with your data model


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Results"
        let rightBarButton = UIBarButtonItem(title: "All Books", style: .plain, target: self, action: #selector(rightBarButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButton

        // Do any additional setup after loading the view.
    }
    @objc func rightBarButtonTapped() {
        let allbookCon:allBooksView = self.storyboard?.instantiateViewController(identifier: "books_screen") as! allBooksView
        navigationController?.pushViewController(allbookCon, animated: true)
       }
    

}
