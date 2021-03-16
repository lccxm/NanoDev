//
//  main.swift
//  NanoDev
//
//  Created by Lucca Molon and Matheus Polonia on 16/03/21.
//

// funcionalidades -> postar, responder, ver posts, like
import Foundation



struct MainPage {
    var allPosts: [Post]
    
    mutating func createPost(text: String, username: String, likes: Int) -> Void {
        let post = MainPost(username: username, text: text, likes: likes, replies: [])
        allPosts.append(post)
    }
    
    mutating func like(position: Int) -> Void {
        allPosts[position - 1].likes += 1
        order(position: position)
    }
    
    mutating func order(position: Int) {
        var index: Int = position - 1
        for i in (0...position - 1).reversed() { // [2][2][3][1]
            if i == 0 && allPosts[position].likes > allPosts[0].likes {
                allPosts.insert(allPosts[position], at: 0)
                allPosts.remove(at: position + 1)
            }else if i == 0 && allPosts[position].likes <= allPosts[0].likes {
                allPosts.insert(allPosts[position], at: 1)
                allPosts.remove(at: position + 1)
            }else if allPosts[position].likes <= allPosts[i - 1].likes {
                allPosts.insert(allPosts[position], at: index + 1)
                allPosts.remove(at: position + 1)
            }
            index -= 1
        }
    }
    
    func toString(post: Post) {
        print("text: \(post.text)\nlikes: \(post.likes)\n")
    }
    
    func printAll() {
        for i in allPosts {
            toString(post: i)
        }
    }
}

protocol PostDate {
    var date: Date { get set }
}

protocol Post {
    var username: String { get set }
    var text: String { get set }
    var likes: Int { get set }
    var replies: [Reply] { get set }
}

struct MainPost: Post {
    var username: String
    var text: String
    var likes: Int
    var replies: [Reply]
}

struct Reply: Post {
    var username: String
    var text: String
    var likes: Int
    var replies: [Reply]
}


var main = MainPage(allPosts: [])
main.createPost(text: "hello", username: "a", likes: 3) // 0
main.createPost(text: "hello1", username: "b", likes: 2) // 1
main.createPost(text: "hello2", username: "c", likes: 2) // 2
main.createPost(text: "hello3", username: "d", likes: 1) // 3

//main.printAll()

main.printAll()
print("------")
main.like(position: 3)
main.printAll()

//main.printAll()


