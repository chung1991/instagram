//
//  PostService.swift
//  MobileSocialApp
//
//  Created by Chung EXI-Nguyen on 6/19/22.
//

import Foundation


struct PostService {
    let calendar = Calendar.current
    
    func getPosts() -> [UserPost] {
        var ans: [UserPost] = []
        for i in 0..<20 {
            ans.append(randomPost(i))
        }
        return ans
    }
    
    private func randomPost(_ id: Int) -> UserPost {
        let post = UserPost(id: id,
                            userName: randomUsername(),
                            caption: randomCaption(),
                            postDate: randomDate(),
                            photos: randomPhotos())
        return post
    }
    
    private func randomPhotos() -> [Photo] {
        let randomPhotoCount = Int.random(in: 1...10)
        var photos: [Photo] = []
        let baseURL = "https://picsum.photos/200/300?random="
        for _ in 0..<randomPhotoCount {
            let url = baseURL + "\(Int.random(in: 1...300))"
            let caption = randomCaption()
            let photo = Photo(id: UUID(),
                              caption: caption,
                              url: url)
            photos.append(photo)
        }
        return photos
    }
    
    private func randomUsername() -> String {
        return ["Mike", "Brian", "Cole", "Mia"].randomElement()!
    }
    
    private func randomDate() -> Date {
        let diff = Int.random(in: (-100)...(-1))
        let now = Date()
        guard let newDate = calendar.date(byAdding: .day, value: diff, to: now) else {
            assertionFailure()
            return Date()
        }
        return newDate
    }
    
    private func randomCaption() -> String {
        let randomWordCount = Int.random(in: 10...100)
        var words: [String] = []
        for _ in 0..<randomWordCount {
            let randomWordLen = Int.random(in: 2...10)
            words.append(randomWord(wordLength: randomWordLen))
        }
        return words.joined(separator: " ")
    }
    
    private func randomWord(wordLength: Int = 6) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((1..<wordLength).map{ _ in letters.randomElement()! })
    }

}
