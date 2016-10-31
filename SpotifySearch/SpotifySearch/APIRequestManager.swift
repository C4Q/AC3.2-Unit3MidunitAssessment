//
//  APIRequestManager.swift
//  SpotifySearch
//
//  Created by Jermaine Kelly on 10/28/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import Foundation

class APIRequestManager{
    static let manager: APIRequestManager = APIRequestManager()
    private init() {}
    

    
    
    func getData(from endpoint: String, completion: @escaping ((Data?)-> Void)){
        
        guard let url: URL = URL(string: endpoint) else { return }
        
        let session: URLSession =  URLSession(configuration: .default)
        
        session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
           
            if error != nil{
                print("ERROR =======> \n \(error.debugDescription) \n =======")
            }
            guard let validData = data else{ return }
            completion(validData)
            
            }.resume()
        
    }
    
    
    
    
    
    
}
