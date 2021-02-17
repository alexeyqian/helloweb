import Vapor

struct TodoAPIModel: Content{
    let id: Todo.IDValue
    let title: String
    let completed: Bool
    let order: Int?
    let url: String
}

extension TodoAPIModel{
    init(_ todo: Todo){
        //self.id = try todo.requireID() //TODO: ??
        self.id = UUID()
        self.title = todo.title
        self.completed = todo.completed
        self.order = todo.order
        self.url = "https://xxx/todos/\(self.id)"
    }
}
