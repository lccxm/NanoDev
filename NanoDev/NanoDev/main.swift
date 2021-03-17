//
//  main.swift
//  NanoDev
//
//  Created by Lucca Molon and Matheus Polonia on 16/03/21.
//

// funcionalidades -> postar, responder, ver posts, like
import Foundation



struct MainPage {
    var allPosts: [Post] = []
    
    mutating func createPost(username: String) -> Void {
        var post = MainPost(username: username)
        print("Message: ")
        let message = readLine()
        if let m = message {
            post.text = m
        }
        allPosts.append(post)
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
    
    func toString(post: Post) {
        print("\n\(post.username)\n\(post.text)\nlikes: \(post.likes)\n\(post.date)\n")
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

protocol Post: PostDate {
    var username: String { get set }
    var text: String { get set }
    var likes: Int { get set }
    var replies: [Reply] { get set }
    var date: Date { get set }
}

struct MainPost: Post {
    var username: String
    var text: String = ""
    var likes: Int = 0
    var replies: [Reply] = []
    var date: Date = Date()
}

struct Reply: Post {
    var username: String
    var text: String = ""
    var likes: Int = 0
    var replies: [Reply] = []
    var date: Date = Date()
}

func printMenu() {
    print("-------------------------")
    print("| 1 - New Post          |\n| 2 - Like a Post       |\n| 3 - Dislike a Post    |\n| 4 - Reply             |")
    print("-------------------------")
}

func run() {
    var main = MainPage()
    // populate main page
    
    print("Escolha seu username: ")
    let name = readLine()
    while true {
        printMenu()
        var number = readLine()
        if let n = number {
            if Int(n)! <= 0 {
                break
            }else {
                switch Int(n) {
                case 1:
                    if let username = name {
                        main.createPost(username: username)
                    }
                case 2:
                    print("Which Post? ")
                    let p = readLine()
                    if let post = p {
                        main.like(position: Int(post)!)
                    } // tratamento de erro
                case 3:
                    print("Which Post? ")
                    let p = readLine()
                    if let post = p {
                        main.dislike(position: Int(post)!)
                    }
                case 4:
                    return
                    // codar createReply()
                default:
                    print("Invalid Input :(")
                }
            }
            main.printAll()
        }
    }
    
}

run()
//main.createPost(text: "hello", username: "a", likes: 3)  // 0   primeiro criado
//main.createPost(text: "hello1", username: "b", likes: 3) // 1
//main.createPost(text: "hello2", username: "c", likes: 2) // 2
//main.createPost(text: "hello3", username: "d", likes: 1) // 3

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

//print("Digite seu username: ")
//var a = readLine()
//if let string = a {
//    print(string)
//}


