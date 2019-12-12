//
//  gitTests.swift
//  gitTests
//
//  Created by mostfa on 12/9/19.
//  Copyright © 2019 mostfa. All rights reserved.
//

import XCTest
import Quick
import Nimble
import Hippolyte
import Mockingjay
@testable import git


class gitNetworkTestWithDataError: QuickSpec  {
    var testItems:[GitItem]?
    var testError:GitNetworkError?
         let X = """
  [
    {
      "id" : 98115230,
      "node_id" : "MDEwOlJlcG9zaXRvcnk5ODExNTIzMA==",
      "name" : "Animate",
      "full_name" : "JohnSundell/Animate",
      "owner" : {
        "login" : "JohnSundell",
        "id" : 2466701,
        "node_id" : "MDQ6VXNlcjI0NjY3MDE=",
        "avatar_url" : "https://avatars3.githubusercontent.com/u/2466701?v=4",
        "gravatar_id" : "",
        "url" : "https://api.github.com/users/JohnSundell",
        "html_url" : "https://github.com/JohnSundell",
        "followers_url" : "https://api.github.com/users/JohnSundell/followers",
        "following_url" : "https://api.github.com/users/JohnSundell/following{/other_user}",
        "gists_url" : "https://api.github.com/users/JohnSundell/gists{/gist_id}",
        "starred_url" : "https://api.github.com/users/JohnSundell/starred{/owner}{/repo}",
        "subscriptions_url" : "https://api.github.com/users/JohnSundell/subscriptions",
        "organizations_url" : "https://api.github.com/users/JohnSundell/orgs",
        "repos_url" : "https://api.github.com/users/JohnSundell/repos",
        "events_url" : "https://api.github.com/users/JohnSundell/events{/privacy}",
        "received_events_url" : "https://api.github.com/users/JohnSundell/received_events",
        "type" : "User",
        "site_admin" : false
      },
      "description" : "Declarative UIView animations without nested closures",
      "fork" : false,
      "url" : "https://api.github.com/repos/JohnSundell/Animate",
      "created_at" : "2017-07-23T17:50:37Z",
      "forks_count" : 21,
      "forks" : 21,
      "html_url" : "https://github.com/JohnSundell/Ink",
      "language" : "Swift"
    },
    
      "id" : 224025653,
      "node_id" : "MDEwOlJlcG9zaXRvcnkyMjQwMjU2NTM=",
      "name" : "Ink",
      "html_url" : "https://github.com/JohnSundell/Ink",
      "description" : "A fast and flexible Markdown parser written in Swift.",
      "url" : "https://api.github.com/repos/JohnSundell/Ink",
      "created_at" : "2019-11-25T19:30:54Z",
      "language" : "Swift",
      "forks_count" : 47,
      "forks" : 47,
      "owner" : {
        "login" : "JohnSundell",
        "id" : 2466701,
        "node_id" : "MDQ6VXNlcjI0NjY3MDE=",
        "avatar_url" : "https://avatars3.githubusercontent.com/u/2466701?v=4",
        "gravatar_id" : "",
        "url" : "https://api.github.com/users/JohnSundell",
        "html_url" : "https://github.com/JohnSundell",
        "followers_url" : "https://api.github.com/users/JohnSundell/followers",
        "following_url" : "https://api.github.com/users/JohnSundell/following{/other_user}",
        "gists_url" : "https://api.github.com/users/JohnSundell/gists{/gist_id}",
        "starred_url" : "https://api.github.com/users/JohnSundell/starred{/owner}{/repo}",
        "subscriptions_url" : "https://api.github.com/users/JohnSundell/subscriptions",
        "organizations_url" : "https://api.github.com/users/JohnSundell/orgs",
        "repos_url" : "https://api.github.com/users/JohnSundell/repos",
        "events_url" : "https://api.github.com/users/JohnSundell/events{/privacy}",
        "received_events_url" : "https://api.ginthub.com/users/JohnSundell/received_events",
        "type" : "User",
        "site_admin" : false
      
  
  
  """

    
      override func spec() {
        super.spec()

        guard let gitUrl = URL(string: "https://api.github.com/users/dde/repos") else { return }
        var stub = StubRequest(method: .GET, url: gitUrl)
        var response = StubResponse()
            

         let data = X.data(using: .utf8)!

        let body = data
        response.body = body as Data
        stub.response = response
        Hippolyte.shared.add(stubbedRequest: stub)
        Hippolyte.shared.start()
        

    
        describe("requestUserWithData") {
          context("Failure") {
            it("it returns error") {

                GitDataDownloader.shared.downloadRepos(for: "dde") { (items,error) in
                    
                    self.testItems = items
                    self.testError = error

                    if case .GenericError = error {
                        XCTAssert(true)
                        
                    }else {
                        
                        XCTAssert(false)

                    }
                }
                
           

                expect(self.testItems).toEventually(beNil())


            
                
                
                

            }
          }
        }
      }
    }

