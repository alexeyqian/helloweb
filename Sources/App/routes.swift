import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }
    
    app.get("hello2") { req -> EventLoopFuture<View> in
        return req.view.render("hello", ["name": "Leaf"])
    }
    
    app.get("hello3") { req -> EventLoopFuture<View> in
        return req.view.render("hello", ["name": "Leaf2"])
    }
    

}
