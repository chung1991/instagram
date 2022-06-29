//
//  Models.swift
//  MobileSocialApp
//
//  Created by Chung EXI-Nguyen on 6/23/22.
//

import Foundation

struct UserPost {
    let id: Int
    let userName: String
    let caption: String
    let postDate: Date
    let photos: [Photo]
}

struct Photo {
    let id: UUID
    let caption: String
    let url: String
}
