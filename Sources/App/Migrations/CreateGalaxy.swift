import Vapor
import Fluent
import FluentMySQLDriver

struct CreateGalaxy: Migration{
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("galaxies")
            .id()
            .field("name", .string)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void>{
        database.schema("galaxies").delete()
    }
}
