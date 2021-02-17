import Vapor

final class BookAPIController{
    struct Book: Content{
        let id: Int
        let title: String
        let author: String
    }
    
    static let books = [
        Book(id: 1, title: "Server Side Swift with Vapor", author: "raywenderlich.com"),
        Book(id: 2, title: "Server Side Swift (Vapor Edition)", author: "Hacking with Swift"),
        Book(id: 3, title: "Hands-On Swift 5 Microservices Development", author: "Ralph Kuepper")
    ]
    
    func getBooks(req: Request) -> [Book]{
        return Self.books
    }
    
    func getBook(req: Request) throws -> Book{
        guard let bookIDString = req.parameters.get("bookID"),
              let bookID = Int(bookIDString),
              let book = Self.books.first(where: {$0.id == bookID}) else {
            throw Abort(.notFound)
        }
        
        return book
    }
}

extension BookAPIController: RouteCollection{
    func boot(routes: RoutesBuilder) throws {
        routes.get("", use: getBooks)
        routes.get(":bookID", use: getBook)
    }
}
