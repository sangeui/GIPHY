//
//  GIFLoader.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/21.
//

import UIKit

class GIFLoader {
    private var request: URLSessionDataTask? = nil
    
    func cancel() {
        self.request?.cancel()
    }
    
    func load(urlString: String?, success: @escaping ([UIImage]) -> Void) {
        self.request?.cancel()
        
        guard let url = URL(string: urlString ?? "") else { return }
        
        DispatchQueue.global(qos: .background).async {
            self.request = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
                guard let data = data as CFData? else { return }
                
                guard let images = CGImageSourceCreateWithData(data, nil) else { return }
                
                let animationImages: [UIImage] = (0..<CGImageSourceGetCount(images)).compactMap { index in
                    guard let cgImage = CGImageSourceCreateImageAtIndex(images, index, nil) else { return nil }
                    return UIImage(cgImage: cgImage)
                }
                
                success(animationImages)
            })
            self.request?.resume()
        }
    }
}
