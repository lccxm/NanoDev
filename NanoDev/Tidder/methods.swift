import Foundation

struct MainMethods {
    var allPosts: [Post] = []
    
    mutating func createPost(username: String) -> Post {
        var post = Post(username: username)
        print("Post Title: ")
        let t = readLine()
        if let title = t {
            post.title = title
        }
        post.text = readTextEntry()
        return post
    }
    
    func readTextEntry() -> [String] {
        var arrayPhrases: [String] = []
        print("Enter a post: (enter ˜ to cancel)")
        while let input = readLine() {
            guard input != "˜" else {
                break
            }
            arrayPhrases.append(input)
        }
        return arrayPhrases
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
    
    func changeLike(option: Int, position: Int, array: [Post]) -> [Post] {
        var newArray = array
        if option == 0 { // Dislike
            if newArray[position - 1].likes != 0 {
                newArray[position - 1].likes -= 1
            }
        } else { //like
            newArray[position - 1].likes += 1
        }
        return newArray.sorted { comparePost(p1: $0, p2: $1) }
    }
    
    func retunPostText(array: [String]) -> String{
        var postText: String = "|"
        for p in array {
            postText += (p + "\n|")
        }
        return postText
    }

    func retunReplyText(array: [String], level: Int) -> String{
        var tab = ""
        for _ in 0...level{
            tab += "\t"
        }
        var postText: String = "\(tab)|"
        for p in array {
            postText += (p + "\n\(tab)|")
        }
        return postText
    }
    
    func differenceInDays(date: Date) -> String{
            let difference = Date().timeIntervalSince(date)
            if Int(difference)/86400 > 0 {
                if Int(difference)/86400/360 > 0{
                    return "\(Int(difference)/86400/360) years ago"
                } else {
                    return "\(Int(difference)/86400) days ago"
                }
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
    
    func printPostFormated(post: Post, number: Int) {
        var dash = "\n______________________"
        for _ in 0...post.username.count{
            dash += "_"
        }
        print("\(dash)\n▸ Posted by u/\(post.username)  \(differenceInDays(date: post.date)) \n|\n|\t\(post.title) \n\(retunPostText(array: post.text)) \n|↶ Replies: \(post.replies.count)   ★ Likes: \(post.likes)   Post Number: \(number)")
        printReplyFormated(replys: post.replies, level: 1)
        }
    
    func printReplyFormated(replys: [Post], level: Int) {
            var t = ""
            for _ in 0...level{
                t += "\t"
            }
            if !replys.isEmpty {
                for reps in replys {
                    var dash = "____________"
                    for _ in 0...reps.username.count{
                        dash += "_"
                    }
                    print("\(t)\(dash) \n \(t)|u/\(reps.username)  \(differenceInDays(date: reps.date)) \n\(t)|\n\(t)|\t\(reps.title) \n\(retunReplyText(array: reps.text, level: level)) \n\(t)|↶ Replies: \(reps.replies.count)   ★ Likes: \(reps.likes)  Reply Number: \(Int(replys.firstIndex(where: { $0.date == reps.date }) ?? 0) + 1)")
                    printReplyFormated(replys: reps.replies, level: level + 1)
                }
            }
        }
    
    func printAll() {
        var number = 1
        for i in allPosts {
            printPostFormated(post: i, number: number)
            number += 1
        }
    }
    
    func printLineClearTerminal() {
        for _ in 1...20 {
            print("\n")
        }
    }
}
