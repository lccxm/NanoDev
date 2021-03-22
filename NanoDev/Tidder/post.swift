import Foundation

protocol PostDate {
    var date: Date { get set }
}

struct Post: PostDate {
    var username: String
    var title: String = ""
    var text: [String] = []
    var likes: Int = 0
    var replies: [Post] = []
    var date: Date = Date()
}
