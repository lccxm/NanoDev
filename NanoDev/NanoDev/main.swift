//
//  main.swift
//  NanoDev
//
//  Created by Lucca Molon and Matheus Polonia on 16/03/21.
//

// funcionalidades -> postar, responder, ver posts, like, dislike
import Foundation

let dateFormatter = DateFormatter()
dateFormatter.dateStyle = .short
dateFormatter.timeStyle = .short

struct MainPage {
    var allPosts: [Post] = []
    
    mutating func createPost(username: String) -> Void {
        var post = Post(username: username)
        print("Post Title: ")
        let t = readLine()
        if let title = t {
            post.title = title
        }
         post.text = readPostText()
        allPosts.append(post)
    }
    
    func readPostText() -> String {
            var arrayPhrases: [String] = []

            print("Enter a post: (enter ˜ to cancel)")

            while let input = readLine() {
                guard input != "˜" else {
                    break
                }
                arrayPhrases.append(input)
            }
            var postText: String = ""

            for p in arrayPhrases {
                postText += (p + "\n")
            }

            return postText
        }
    
    mutating func like(position: Int) -> Void {
        allPosts[position - 1].likes += 1
        order()
    }
    
    mutating func dislike(position: Int) {
        if allPosts[position - 1].likes != 0 {
            allPosts[position - 1].likes -= 1
            order()
        }// falta tratamento de erro
    }
    
    mutating func order() {
        allPosts.sort { (p1, p2) -> Bool in
            if p1.likes > p2.likes{
                return true
            } else if p1.likes == p2.likes {
                if p1.date < p2.date {
                    return true
                }
                else {
                    return false
                }
            }
            return false
        }
    }
    
    mutating func createReply(position: Int, username: String) {
        var post = Post(username: username)
        print("Message: ")
        let message = readLine()
        if let m = message {
            post.text = m
        }
        allPosts[position - 1].replies.append(post)
    }
    
    func toString(post: Post) {
        print("\n\(post.username)\n\(post.text)\nlikes: \(post.likes)\n\(dateFormatter.string(from: post.date))\nReplies: \(post.replies.count)")
    }
    
    func titleToString(post: Post) {
        print("|Author: \(post.username) Title: \(post.title) Replies: \(post.replies.count)|")
    }
    
    
    func printAll() {
        for i in allPosts {
            toString(post: i)
        }
    }
    
    func printAllTitles() {
        for post in allPosts {
            titleToString(post: post)
        }
    }
}

protocol PostDate {
    var date: Date { get set }
}

struct Post: PostDate {
    var username: String
    var title: String = ""
    var text: String = ""
    var likes: Int = 0
    var replies: [Post] = []
    var date: Date = Date()
}

func printMenu() {
    print("------------------------------------------------------------")
    print("|1| New Post |2| Access Post |3| Like |4| Dislike |˜| Exit")
    print("------------------------------------------------------------")
}

func run() {
    var main = MainPage()
    
    // populate main page
    
    print("Escolha seu username: ")
    let name = readLine()
    while true {
        printMenu()
        let number = readLine()
        if let n = number {
            if n == "˜" {
                break
            }
            switch Int(n) {
            case 1:
                if let username = name {
                    main.createPost(username: username)
                }
            case 2:
                return
            case 3:
                print("Which Post? ")
                let p = readLine()
                if let post = p {
                    main.like(position: Int(post)!)
                } // tratamento de erro
            case 4:
                print("Which Post? ")
                let p = readLine()
                if let post = p {
                    main.dislike(position: Int(post)!)
                }
            default:
                break
            }
            main.printAllTitles()
        }
    }
    
}

run()
//main.createPost(text: "hello", username: "a", likes: 3)  // 0   primeiro criado
//main.createPost(text: "hello1", username: "b", likes: 3) // 1
//main.createPost(text: "hello2", username: "c", likes: 2) // 2
//main.createPost(text: "hello3", username: "d", likes: 1) // 3
//
//main.printAll()
//print("------")
//main.like(position: 3)
//main.printAll()
//print("------")
//main.like(position: 3)
//main.printAll()
//print("------")
//main.like(position: 2)
//main.printAll()
//print("------")
//main.dislike(position: 2)
//main.printAll()
//print("------")
//
//print("Digite seu username: ")
//var a = readLine()
//if let string = a {
//    print(string)
//}


