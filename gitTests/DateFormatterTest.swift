//
//  DateFormatterTest.swift
//  gitTests
//
//  Created by mostfa on 12/13/19.
//  Copyright © 2019 mostfa. All rights reserved.
//

import Foundation
import XCTest
import Quick
import Nimble
import Hippolyte
import Mockingjay

@testable import git


class DateFormatterTest: QuickSpec  {
    
    override func spec() {
    super.spec()
    
    describe("Date formatting") {
           context("Success") {
            it("returns expected value") {
               let item1 = GitItem(id: 2019, nodeId: "29182", name: "Mostfa", forksCount: 43, description: "testing date", language: "Swift", htmlUrl: "http://google.com", createdAt: "2017-07-23T17:50:37Z")
                
        
               expect( item1.formattedDate()) == "23-07-2017"
                
                
                
            }}}
    
    }
    
}
