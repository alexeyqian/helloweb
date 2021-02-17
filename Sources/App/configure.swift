import Vapor
import Leaf
import Fluent
import FluentMySQLDriver

// configures your application
public func configure(_ app: Application) throws {
    //app.http.server.configuration.port = 8081
    
    // views
    app.views.use(.leaf)
    
    // middlewares
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.middleware.use(CORSMiddleware())
    // databae
    app.databases.use(.mysql(hostname: "127.0.0.1",
                             username: "root", password: "yournewpassword", database: "vapor",
                             tlsConfiguration: .forClient(certificateVerification: .none)), as: .mysql)
    
    // migrations
    app.migrations.add(CreateGalaxy())
    app.migrations.add(CreateTodo())
    try app.autoMigrate().wait()
    
    try routes(app)
}
