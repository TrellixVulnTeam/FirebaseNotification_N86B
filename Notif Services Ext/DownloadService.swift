//
//  DownloadService.swift
//  For Sell
//
//  Created by Tom on 20/03/2018.
//  Copyright © 2018 Tom. All rights reserved.
//

import Foundation


class DownloadService {
    
    private init() {}
    static let shared = DownloadService()
    
    func getImage(with urlString: String, completion: @escaping (URL) -> Void) {
        guard let url = URL(string: urlString) else {return}
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, _, _) in
            
            let fileManager = FileManager.default
            
            guard let data = data,
                let documentUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
                else { return }
            
            let fileUrl = documentUrl.appendingPathComponent("image.jpg")
            do{
                try data.write(to: fileUrl)
                DispatchQueue.main.async {
                    completion(fileUrl)
                }
            }catch{
                print(error)
            }
        
        }
        task.resume()
    }
    
}
