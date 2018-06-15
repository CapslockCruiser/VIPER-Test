//
//  ImageManager.swift
//  VIPER Test
//
//  Created by William Choi on 6/12/18.
//  Copyright © 2018 William Choi. All rights reserved.
//

import UIKit

final class ImageManager {
    
    private var environment: Environment
    private var images: [URL: UIImage?] = [:]
    
    init(environment: Environment) {
        self.environment = environment
    }
    
    func checkImage(url: URL) -> UIImage? {
        if let image = images[url] {
            return image
        } else {
            return nil
        }
    }
    
    func retrieveImage(url: URL, completion: @escaping (UIImage) -> Void) {
        switch environment {
        case .development:
            var request = URLRequest(url: url)
            if images[url] == nil {
                request.httpMethod = "GET"
                
                URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                    guard error == nil else { return }
                    guard let data = data else { return }
                    guard let image = UIImage(data: data) else { return }
                    completion(image)
                    guard let strongSelf = self else { return }
                    strongSelf.images[url] = image
                }.resume()
            }
        case .production:
            //Retrieve from actual server
            break
        }
    }
    
}
