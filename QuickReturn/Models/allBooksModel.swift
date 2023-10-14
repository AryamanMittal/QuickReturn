//
//  allBooksModel.swift
//  QuickReturn
//
//  Created by aryaman mittal on 13/10/23.
//

import Foundation
class AllBooks: Codable {
    let success: Bool
    let data: [Books]
    let message: String

    init(success: Bool, data: [Books], message: String) {
        self.success = success
        self.data = data
        self.message = message
    }
}
class IssBook: Codable {
    var bookId: String = ""
    init(bookId: String) {
        self.bookId = bookId
    }
    init(){
        
    }
}
// MARK: - Datum
class Books: Codable {
    let id, name, author: String
    let price, pages, available, total: Int
    let description: String
    let books: [String]
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, author, price, pages, available, total, description, books
        case v = "__v"
    }

    init(id: String, name: String, author: String, price: Int, pages: Int, available: Int, total: Int, description: String, books: [String], v: Int) {
        self.id = id
        self.name = name
        self.author = author
        self.price = price
        self.pages = pages
        self.available = available
        self.total = total
        self.description = description
        self.books = books
        self.v = v
    }
}
