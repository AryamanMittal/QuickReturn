//
//  issuedBooksModel.swift
//  QuickReturn
//
//  Created by aryaman mittal on 13/10/23.
//

import Foundation
class IssuedBooks: Codable {
    let success: Bool
    let bookCategories: [BookCategory]
    let allBooks: [Allbook]
    let message: String

    enum CodingKeys: String, CodingKey {
        case success, bookCategories
        case allBooks = "all_books"
        case message
    }

    init(success: Bool, bookCategories: [BookCategory], allBooks: [Allbook], message: String) {
        self.success = success
        self.bookCategories = bookCategories
        self.allBooks = allBooks
        self.message = message
    }
}
class Allbook: Codable {
    let id, bookID, condition: String
    let count: Int
    let issueDate, deadline, categoryID: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case bookID = "book_id"
        case condition, count
        case issueDate = "issue_date"
        case deadline
        case categoryID = "category_id"
        case v = "__v"
    }

    init(id: String, bookID: String, condition: String, count: Int, issueDate: String, deadline: String, categoryID: String, v: Int) {
        self.id = id
        self.bookID = bookID
        self.condition = condition
        self.count = count
        self.issueDate = issueDate
        self.deadline = deadline
        self.categoryID = categoryID
        self.v = v
    }
}

// MARK: - BookCategory
class BookCategory: Codable {
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
