//
//  DownloadService.swift
//  MobileSocialApp
//
//  Created by Chung EXI-Nguyen on 6/19/22.
//

import Foundation
import UIKit

class DownloadService {
    static let shared = DownloadService()
    var data: [String: UIImage] = [:]
    func getPhoto(_ url: String, _ completion: @escaping (UIImage?)->Void) {
        guard let image = data[url] else {
            downloadFile(url) { [weak self] image in
                self?.data[url] = image
                completion(image)
            }
            return
        }
        completion(image)
    }
    
    private func downloadFile(_ url: String, _ completion: @escaping (UIImage?)->Void) {
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: url)!)) { data, response, error in
            guard error == nil, let data = data else {
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            completion(image)
            
        }.resume()
    }
}

