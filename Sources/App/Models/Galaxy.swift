import Foundation
import Vapor
import Fluent
import FluentMySQLDriver

final class Galaxy: Model{
    static let schema = "galaxies"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    init(){}
    
    init(id: UUID? = nil, name: String){
        self.id = id
        self.name = name
    }
}


