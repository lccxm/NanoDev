//
//  main.swift
//  NanoDev
import Foundation

func printMenu() {
    print("")
    print("----------------------------------------------------------------------")
    print("| [1] New Post | [2] Access Post | [3] Like | [4] Dislike | [0] Exit |")
    print("----------------------------------------------------------------------")
    print("Enter a Option:")
}

func printPostMenu() {
    for _ in 1...2 {
        print("\n")
    }
    print("----------------------------------------------------------------------------------------------------")
    print("| [1] Like Post | [2] Dislike Post | [3] Reply | [4] Like a reply | [5] Dislike a reply | [0] Exit |")
    print("----------------------------------------------------------------------------------------------------")
    print("Enter a Option:")
}

func readKeyboardNumber() -> Int{
    let readOptionalString = readLine()
    if let readString = readOptionalString {
        if let readInt = Int(readString) {
            return readInt
        } else {
            return -1
        }
    } else {
        return -1
    }
}

func readPositionNumber(maxRange: Int) -> Int{
    print("Enter a postion number:")
    while true {
        let number: Int = readKeyboardNumber()
        switch number {
        case 0:
            print("exiting....")
            return -1
        case 1...maxRange - 1:
            return number
        default:
            print("Invalid Option! Please enter a valid post number or [0] to exit:")
        }
    }
}

func postLoop(main: MainMethods, postPosition: Int, userName: String) {
    var main: MainMethods = main
    let userName: String = userName
    
    var loopControlPost: Bool = true
    while loopControlPost == true {
        let currentPost: Post = main.allPosts[postPosition - 1]
        main.printPostFormated(post: currentPost, number: postPosition)
        printPostMenu()
        var loopControlPostMenu: Bool = true
        while loopControlPostMenu == true {
            let menuOption = readKeyboardNumber()
            switch menuOption {
            case 0: // Exite to main loop
                loopControlPost = false
                loopControlPostMenu = false
            case 1: //Like current post
                main.allPosts = main.changeLike(option: 1, position: postPosition, array: main.allPosts)
                loopControlPostMenu = false
            case 2: // Dislike current post
                main.allPosts = main.changeLike(option: 0, position: postPosition, array: main.allPosts)
                loopControlPostMenu = false
            case 3: // Reply to current post
                main.printLineClearTerminal()
                main.allPosts[postPosition - 1].replies.append(main.createPost(username: userName))
                loopControlPostMenu = false
            case 4: // Like a Reply
                let option = readPositionNumber(maxRange: currentPost.replies.count + 1)
                if option != -1 {
                    main.allPosts[postPosition - 1].replies = main.changeLike(option: 1, position: option, array: currentPost.replies)
                    loopControlPostMenu = false
                } else {
                    loopControlPostMenu = false
                }
            case 5: // Dislike a reply
                let option = readPositionNumber(maxRange: currentPost.replies.count + 1)
                if option != -1 {
                    main.allPosts[postPosition - 1].replies = main.changeLike(option: 0, position: option, array: currentPost.replies)
                    loopControlPostMenu = false
                } else {
                    loopControlPostMenu = false
                }
            default:
                print("\nEnter a valid option or [0] to exit:")
            }
        }
    }
}

func mainLoop(main: MainMethods, userName: String) {
    var main = main
    let userName = userName
    
    var loopControlMain: Bool = true // Control variable for main while
    while loopControlMain == true{ // Main loop through the application
        main.printLineClearTerminal()
        printTidderArt()
        main.printAll()
        printMenu()
        var loopControlMenu: Bool = true // Control variable for menu while
        while loopControlMenu == true { // Menu loop to select an option
            let mainOption = readKeyboardNumber()
            switch mainOption {
            case 0: // End loop
                loopControlMain = false
                loopControlMenu = false
            case 1: //Creat a Post
                main.printLineClearTerminal()
                print("CREATE A NEW POST")
                main.allPosts.append(main.createPost(username: userName))
                loopControlMenu = false
            case 2: //Enter a Post
                let option = readPositionNumber(maxRange: main.allPosts.count + 1)
                if option != -1 {
                    main.printLineClearTerminal()
                    postLoop(main: main, postPosition: option, userName: userName)
                    loopControlMenu = false
                } else {
                    loopControlMenu = false
                }
            case 3: //Like a Post
                let option = readPositionNumber(maxRange: main.allPosts.count + 1)
                if option != -1 {
                    main.allPosts = main.changeLike(option: 1, position: option, array: main.allPosts)
                    loopControlMenu = false
                } else {
                    loopControlMenu = false
                }
            case 4: //Dislike a Post
                let option = readPositionNumber(maxRange: main.allPosts.count + 1)
                if option != -1 {
                    main.allPosts = main.changeLike(option: 0, position: option, array: main.allPosts)
                    loopControlMenu = false
                } else {
                    loopControlMenu = false
                }
            default: // Unaccepted keyboard entry
                print("\nEnter a valid option or [0] to exit:")
            }
        }
    }
//    print("acabou")
}


func readUserName() -> String {
    print("Enter your username:")
    while true{
        let keyboardEntry = readLine()
        if let userName = keyboardEntry {
            if !userName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
                return userName
            } else {
                print("Invalid username! Please try again.")
            }
        } else {
            print("Invalid username! Please try again.")
        }
    }
}

func printTidderArt() {
    print("" +
       "    _______  _      _      _   \n" +
       "   |__   __|(_)    | |    | |  \n" +
       "      | |    _   __| |  __| |  ___  _ __ \n" +
       "      | |   | | / _` | / _` | / _ \\| '__| \n" +
       "      | |   | || (_| || (_| ||  __/| | \n" +
       "      |_|   |_| \\__,_| \\__,_| \\___||_| \n\n"
      )
}

func run(main:  MainMethods) {
    printTidderArt()
    let userName = readUserName()
    mainLoop(main: main,userName: userName)
}


var MainPage: MainMethods = MainMethods()

let calendar = Calendar(identifier: .gregorian)

// 1st Post
var POST1: Post = Post(username: "NotKnowPotato")
POST1.date = calendar.date(from: DateComponents(year: 2014, month: 1, day: 15))!
POST1.title = "TIFU by enraging the parents of my girlfriend by pretending not to know what a potato is."
POST1.text = ["Let me tell you that I have made a bad mistake this evening.", "My girlfriend (who let me tell you is only my 2nd girlfriend of all time) said I am \"invited to dinner\" with her and her parents.", "I was very aghast, nervous, and bashful to be invited to such a situation. But I knew it must be done.", "I met them nicely, I should tell you, and it started off in a good way.", "The idea slapped my mind that I should do a comic bit, to make a good impression and become known to them as a person who is amusing.", "When I saw that baked potatoes were served I got the idea that it would be very good if I pretended I did not know what potatoes was. That would be funny.", "Well let me tell you: backfired on my face. I'll tell you how."]
POST1.likes = 132

// 2nd Post
var POST2: Post = Post(username: "GoldPurpleWildcat")
POST2.date = calendar.date(from: DateComponents(year: 2020, month: 3, day: 21, hour: 23))!
POST2.title = "What’s your “comfort movie”?"
POST2.text = [""]

var REPLY1: Post = Post(username: "MrSquiggles119")
REPLY1.date = calendar.date(from: DateComponents(year: 2020, month: 3, day: 22, hour: 3))!
REPLY1.title = "WALL-E"
REPLY1.text = [""]
REPLY1.likes = 20

var REPLY2: Post = Post(username: "Judge_Winter")
REPLY2.date = calendar.date(from: DateComponents(year: 2020, month: 3, day: 22, hour: 5))!
REPLY2.title = "Emperor’s New Groove"
REPLY2.text = ["I feel like I only watch movies that are nostalgic and cozy but when I’m having a real tough time"]
REPLY2.likes = 33

var REPLY3: Post = Post(username: "rikkrock")
REPLY3.date = calendar.date(from: DateComponents(year: 2020, month: 3, day: 22, hour: 5))!
REPLY3.title = "Ratatouille"
REPLY3.text = ["That movie is the equivalent of a warm hug"]
REPLY3.likes = 55

POST2.replies.append(REPLY1)
POST2.replies.append(REPLY2)
POST2.replies.append(REPLY3)

// 3rd Post
var POST3: Post = Post(username: "SplortscasterSteve")
POST3.date = calendar.date(from: DateComponents(year: 2020, month: 3, day: 18, hour: 10))!
POST3.title = "Blaseball Facts”?"
POST3.text = ["Fun Fact: Despite never having more than 30 wins in a season the Tokyo Lift have made it to the post-season more times (1) than the 13 season veteran Miami Dale (0)"]
POST3.likes = 25

var REPLY4: Post = Post(username: "Deserterdragon")
REPLY4.date = calendar.date(from: DateComponents(year: 2020, month: 3, day: 18, hour: 12))!
REPLY4.title = "Tokyo Lift"
REPLY4.text = ["This is only a fact to people who arent caught up. We're the best team in the league and we're winning the dang thing."]
REPLY4.likes = 8

POST3.replies.append(REPLY4)

// MainPage
MainPage.allPosts.append(POST1)
MainPage.allPosts.append(POST2)
MainPage.allPosts.append(POST3)

run(main: MainPage)




