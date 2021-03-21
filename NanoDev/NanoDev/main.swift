//
//  main.swift
//  NanoDev
//
//  Created by Lucca Molon and Matheus Polonia on 16/03/21.
//

import Foundation

let dateFormatter = DateFormatter()
dateFormatter.dateStyle = .short
dateFormatter.timeStyle = .short

struct MainPage {
    var allPosts: [Post] = []
    
    mutating func createPost(username: String) -> Post {
        var post = Post(username: username)
        print("Post Title: ")
        let t = readLine()
        if let title = t {
            post.title = title
        }
        post.text = readPostText()
        return post
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
    
    mutating func like(position: Int, array: [Post]) -> [Post] {
        var newArray = array
        newArray[position - 1].likes += 1
        return newArray.sorted { comparePost(p1: $0, p2: $1) }
    }
    
    mutating func dislike(position: Int, array: [Post]) -> [Post] {
        var newArray = array
        newArray[position - 1].likes -= 1
        return newArray.sorted { comparePost(p1: $0, p2: $1) }
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

    func toString(post: Post, number: Int) {
        print("\n▸ Posted by u/\(post.username)  \(differenceInDays(date: post.date)) \n\n\(post.text) \n↶ Replies: \(post.replies.count)   ★ Likes: \(post.likes)   Post Number: \(number) \n------------------------------------------------")
        toStringReply(replys: post.replies, level: 1)
        }
    
    func toStringReply(replys: [Post], level: Int) {
            var t = ""
            for _ in 0...level{
                t += "\t"
            }
            if !replys.isEmpty {
                for reps in replys {
                    print("\(t)|\(reps.username)  \(differenceInDays(date: reps.date)) \n\(t)|\n\(t)|\(reps.text) \n\(t)|\n\(t)|↶ Replies: \(reps.replies.count)   ★ Likes: \(reps.likes)  Reply Number: \(Int(replys.firstIndex(where: { $0.date == reps.date }) ?? 0) + 1) \n\(t)--------------------------------------------")
                    toStringReply(replys: reps.replies, level: level + 1)
                }
            }
        }
    
    func printLineClearTerminal() {
            for _ in 1...10 {
                print("\n")
            }
        }
    
    func differenceInDays(date: Date) -> String{
            let difference = Date().timeIntervalSince(date)
            if Int(difference)/86400 > 0 {
                return "\(Int(difference)/86400) days ago"
            } else if Int(difference)/3600  > 0{
                return "\(Int(difference)/3600) hours ago"
            } else if Int(difference)/60 > 30{
                return "\(Int(difference)/60) mins ago"
            } else if Int(difference)/60 > 30 {
                return "30 min ago"
            } else {
                return "just now"
            }
        }
    
    func printAll() {
        var number = 1
        for i in allPosts {
            toString(post: i, number: number)
            number += 1
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
    print("----------------------------------------------------------------------------------------")
    print("|1| Reply |2| Like Post |3| Dislike Post |4| Like a reply |5| Dislike a reply |˜| Exit")
    print("----------------------------------------------------------------------------------------")
}

func printReplyMenu() {
    print("--------------------------------------------")
    print("|1| Reply this post |2| Reply another reply")
    print("--------------------------------------------")
}

func run() {
    var main = MainPage()
    
    // populate main page
    
    print("Escolha seu username: ")
    let nome = readLine()
    guard let name = nome else {
        return
    }
    while true {
        printMenu()
        let number = readLine()
        if let n = number {
            if n == "˜" {
                break
            }
            switch Int(n) {
            case 1:
                 main.allPosts.append(main.createPost(username: name))
            case 2:
                print("Enter a post number: ")
                let p = readLine()
                guard let post = p else{
                    break
                }
                main.toString(post: main.allPosts[Int(post)! - 1], number: Int(post)!)
                while true {
                    printPostMenu()
                    let number = readLine()
                    if let n = number {
                        if n == "˜" {
                            break
                        }else {
                            switch Int(n)! {
                            case 1:
                                printReplyMenu()
                                let a = readLine()
                                if let answer = a {
                                    if Int(answer)! < 1 || Int(answer)! > 2 {
                                        break
                                    }
                                    switch Int(answer)! {
                                    case 1:
                                        main.allPosts[Int(post)! - 1].replies.append(main.createPost(username: name))
                                    case 2:
                                        print("Which Reply? ")
                                        let r = readLine()
                                        if let replyNumber = r {
                                            main.allPosts[Int(post)! - 1].replies[Int(replyNumber)! - 1].replies.append(main.createPost(username: name))
                                        }
                                    default:
                                        print("")
                                    }
                                }
                            case 2:
                                main.allPosts = main.like(position: Int(p!)!, array: main.allPosts)
                            case 3:
                                main.allPosts = main.dislike(position: Int(p!)!, array: main.allPosts)
                            case 4:
                                print("Which Reply? ")
                                let r = readLine()
                                if let replyNumber = r {
                                    main.allPosts[Int(post)! - 1].replies = main.like(position: Int(replyNumber)!, array: main.allPosts[Int(post)! - 1].replies)
                                }
                            case 5:
                                print("Which Reply? ")
                                let r = readLine()
                                if let replyNumber = r {
                                    main.allPosts[Int(post)! - 1].replies = main.dislike(position: Int(replyNumber)!, array: main.allPosts[Int(post)! - 1].replies)
                                }
                            default:
                                print("Invalid Input :(")
                            }
                        }
                    }
                    main.toString(post: main.allPosts[Int(p!)! - 1], number: Int(post)!)
                }
            case 3:
                print("Enter a post number: ")
                let p = readLine()
                if let post = p {
                    main.allPosts = main.like(position: Int(post)!, array: main.allPosts)
                }
            case 4:
                print("Enter a post number: ")
                let p = readLine()
                if let post = p {
                    main.allPosts = main.dislike(position: Int(post)!, array: main.allPosts)
                }
            default:
                print("Invalid Input :(")
            }
            main.printAll()
        }
    }
}
run()
