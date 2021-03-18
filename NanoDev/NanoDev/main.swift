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
    
    mutating func likeReply(Postposition: Int, replyPosition: Int) {
        allPosts[Postposition - 1].replies[replyPosition - 1].likes += 1
        order()
    }
    
    func comparePost(p1: Post, p2: Post) -> Bool {
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
    
    mutating func order() {
        var orderedPosts = allPosts
        orderedPosts.sort { comparePost(p1: $0, p2: $1) }
        allPosts = orderedPosts
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
        print("\n\(post.username)\n\n\(post.text)\nlikes: \(post.likes)\n\(dateFormatter.string(from: post.date))\nReplies: \(post.replies.count)")
    }
    
    func titleToString(post: Post, postNumber: Int) {
        print("Author: \(post.username) | Title: \(post.title) | Likes: \(post.likes) | Replies: \(post.replies.count) | Post Number -> \(postNumber)\n--")
    }
    
    
    func printAll() {
        for i in allPosts {
            toString(post: i)
        }
    }
    
    func printAllTitles() {
        var postNumber = 1
        for post in allPosts {
            titleToString(post: post, postNumber: postNumber)
            postNumber += 1
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

func printPostMenu() {
    print("------------------------------------------------------------------------------------------------------------")
    print("|1| See all replies |2| Reply |3| Like Post |4| Dislike Post |5| Like a reply |6| Dislike a reply |˜| Exit")
    print("------------------------------------------------------------------------------------------------------------")
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
                print("Enter a post number: ")
                let p = readLine()
                if let post = p {
                    main.toString(post: main.allPosts[Int(post)! - 1])
                }
                
                while true {
                    printPostMenu()
                    let number = readLine()
                    if let n = number {
                        if n == "˜" {
                            break
                        }else {
                            switch Int(n)! {
                            case 1:
                                print(main.allPosts[Int(p!)! - 1].replies)
                            case 2:
                                return
                            case 3:
                                main.like(position: Int(p!)!)
                            case 4:
                                main.dislike(position: Int(p!)!)
                            case 5:
                                return
                            case 6:
                                return
                            default:
                                print("Invalid Input :(")
                            }
                        }
                    }
                }
            case 3:
                print("Enter a post number: ")
                let p = readLine()
                if let post = p {
                    main.like(position: Int(post)!)
                } // tratamento de erro
            case 4:
                print("Enter a post number: ")
                let p = readLine()
                if let post = p {
                    main.dislike(position: Int(post)!)
                }
            default:
                print("Invalid Input :(")
            }
            main.printAllTitles()
        }
    }
    
}

run()
