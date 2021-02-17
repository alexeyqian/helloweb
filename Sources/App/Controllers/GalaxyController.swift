import Vapor

final class GalaxyController{
    func getSingle(req: Request) throws -> EventLoopFuture<View>{
        struct GalaxyEntityContent: Encodable{
            let galaxy: Galaxy?
        }
        
        guard let idString = req.parameters.get("id"),
              let id = UUID(idString) else { throw Abort(.notFound) }
        
        return Galaxy.find(id, on: req.db)
            .flatMap{ entity in
                let context = GalaxyEntityContent(galaxy: entity)
                return req.view.render("galaxyDetail", context)
            }
    }
        
    func getMultiple(req: Request) throws -> EventLoopFuture<View> {
        struct GalaxyListContent: Encodable{
            let title: String
            let galaxies: [Galaxy]?
        }
        
        return Galaxy.query(on: req.db).all()
            .flatMap{ tempItems in
                let items = tempItems.isEmpty ? nil : tempItems
                let context = GalaxyListContent(title: "Galaxies", galaxies: items)
                return req.view.render("galaxyList", context)
            }
    }
    
    func showCreateForm(req: Request) throws -> EventLoopFuture<View>{
        return req.view.render("galaxyCreate", ["name": "create galaxy"])
    }
    
    func create(req: Request) throws -> EventLoopFuture<Response>{
        struct GalaxyCreateContent: Content{
            let name: String
        }
        
        let content = try req.content.decode(GalaxyCreateContent.self)
        
        let entity = Galaxy(name: content.name)
        return entity.save(on: req.db)
                .flatMapThrowing { 
                    return req.redirect(to: "galaxies")
                }
    }
}

extension GalaxyController: RouteCollection{
    func boot(routes: RoutesBuilder) throws {
        routes.get("", use: getMultiple)
        routes.get(":id", use: getSingle)
        routes.get("create", use: showCreateForm)
        routes.post("", use: create)
    }
}
