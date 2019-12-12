//
//  WebService.swift
//  git
//
//  Created by mostfa on 12/9/19.
//  Copyright © 2019 mostfa. All rights reserved.
//

import Foundation
class GitDataDownloader: GithubApiClient{
    //SINGTLON
    static let shared =  GitDataDownloader()
    
   
    func downloadRepos(for user:String, completionHandler: @escaping (_ items:[GitItem]?, _ error: GitNetworkError?) -> Void) {





                 let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase



                
                let api = "https://api.github.com/users/\(user)/repos"
                guard let url = URL(string: api) else {return}
                var request =  URLRequest(url: url)
                request.httpMethod = "GET";
                request.allHTTPHeaderFields = ["Content-Type":"application/json","User-Agent":"request"]
               
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            guard let data = data else { completionHandler(nil,.noConnection);return }
                    

                 
                    do{
                        let items =  try decoder.decode(Array<GitItem>.self, from: data)
                        completionHandler(items,nil)
                    }catch {
                        print(error)
                        
                        completionHandler(nil,.GenericError)

                    }

                }.resume()
                
                
        
        
        
        
    }
    
    
    
    
    
}




protocol GithubApiClient {
    func downloadRepos(for user:String ,completionHandler: @escaping (_ items:[GitItem]?, _ error: GitNetworkError?) -> Void)
}



enum GitNetworkError:Error {
    case noConnection
    case GenericError
    
}
