import Vapor

func routes(_ app: Application) throws {
    
    app.get("hello") { req -> String in
        return "Hello, world!"
    }
    
    app.get { req -> EventLoopFuture<View> in
        return req.view.render("home", ["title": "Home"])
    }
    
    struct SolarSystem: Codable{
        var planets = ["enus", "Earth", "Mars"]
    }
    
    app.get("planets"){ req -> EventLoopFuture<View> in
        return req.view.render("planets", SolarSystem())
    }
    
    // api routes
    let apiRoutes = app.grouped("api", "v1")
    
    let bookAPIController = BookAPIController()
    try apiRoutes.grouped("books").register(collection: bookAPIController)
    
    // page routes
    let galaxyController = GalaxyController()
    try app.grouped("galaxies").register(collection: galaxyController)
}
