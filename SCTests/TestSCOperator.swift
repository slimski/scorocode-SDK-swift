//
//  TestSCOperator.swift
//  SC
//
//  Created by Aleksandr Konakov on 16/05/16.
//  Copyright © 2016 Aleksandr Konakov. All rights reserved.
//

import XCTest
@testable import SC

class TestSCOperator: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testName() {
        
        let equalTo = SCOperator.EqualTo("fieldName", SCString("A"))
        XCTAssertEqual(equalTo.name!, "fieldName")
        
        let notEqualTo = SCOperator.NotEqualTo("fieldName", SCBool(false))
        XCTAssertEqual(notEqualTo.name!, "fieldName")
        
        let containedIn = SCOperator.ContainedIn("fieldName", SCArray([SCString("A"), SCString("B")]))
        XCTAssertEqual(containedIn.name!, "fieldName")
        
        let containsAll = SCOperator.ContainsAll("fieldName", SCArray([SCString("A"), SCString("B")]))
        XCTAssertEqual(containsAll.name!, "fieldName")
        
        let notContainedIn = SCOperator.NotContainedIn("fieldName", SCArray([SCString("A"), SCString("B")]))
        XCTAssertEqual(notContainedIn.name!, "fieldName")
        
        let greaterThan = SCOperator.GreaterThan("fieldName", SCInt(5))
        XCTAssertEqual(greaterThan.name!, "fieldName")
        
        let greaterThanOrEqualTo = SCOperator.GreaterThanOrEqualTo("fieldName", SCInt(5))
        XCTAssertEqual(greaterThanOrEqualTo.name!, "fieldName")
        
        let lessThan = SCOperator.LessThan("fieldName", SCInt(5))
        XCTAssertEqual(lessThan.name!, "fieldName")
        
        let lessThanOrEqualTo = SCOperator.LessThanOrEqualTo("fieldName", SCInt(5))
        XCTAssertEqual(lessThanOrEqualTo.name!, "fieldName")
        
        let exists = SCOperator.Exists("fieldName")
        XCTAssertEqual(exists.name!, "fieldName")
        
        let doesNotExist = SCOperator.DoesNotExist("fieldName")
        XCTAssertEqual(doesNotExist.name!, "fieldName")
        
        let contains = SCOperator.Contains("fieldName", "[0-9]", "x")
        XCTAssertEqual(contains.name!, "fieldName")
        
        let startsWith = SCOperator.StartsWith("fieldName", "[0-9]", "x")
        XCTAssertEqual(startsWith.name!, "fieldName")
        
        let endsWith = SCOperator.EndsWith("fieldName", "[0-9]", "x")
        XCTAssertEqual(endsWith.name!, "fieldName")
        
        let or = SCOperator.Or([startsWith, endsWith])
        XCTAssertNil(or.name)
        
        let and = SCOperator.And([startsWith, endsWith])
        XCTAssertNil(and.name)
    }

    func testDic() {
        
        let equalTo = SCOperator.EqualTo("fieldName", SCString("A"))
        XCTAssertEqual((equalTo.dic as! String), "A")
        
        let notEqualTo = SCOperator.NotEqualTo("fieldName", SCBool(false))
        XCTAssertEqual(notEqualTo.dic as! [String : Bool], ["$ne": false])
        
        let containedIn = SCOperator.ContainedIn("fieldName", SCArray([SCString("A"), SCString("B")]))
        XCTAssertEqual(containedIn.dic as! [String : NSArray], ["$in": ["A", "B"]])
        
        let containsAll = SCOperator.ContainsAll("fieldName", SCArray([SCString("A"), SCString("B")]))
        XCTAssertEqual(containsAll.dic as! [String : NSArray], ["$all": ["A", "B"]])
        
        let notContainedIn = SCOperator.NotContainedIn("fieldName", SCArray([SCString("A"), SCString("B")]))
        XCTAssertEqual(notContainedIn.dic as! [String : NSArray], ["$nin": ["A", "B"]])
        
        let greaterThan = SCOperator.GreaterThan("fieldName", SCInt(5))
        XCTAssertEqual(greaterThan.dic as! [String : Int], ["$gt": 5])
        
        let greaterThanOrEqualTo = SCOperator.GreaterThanOrEqualTo("fieldName", SCInt(5))
        XCTAssertEqual(greaterThanOrEqualTo.dic as! [String : Int], ["$gte": 5])
        
        let lessThan = SCOperator.LessThan("fieldName", SCInt(5))
        XCTAssertEqual(lessThan.dic as! [String : Int], ["$lt": 5])
        
        let lessThanOrEqualTo = SCOperator.LessThanOrEqualTo("fieldName", SCInt(5))
        XCTAssertEqual(lessThanOrEqualTo.dic as! [String : Int], ["$lte": 5])
        
        let exists = SCOperator.Exists("fieldName")
        XCTAssertEqual(exists.dic as! [String : Bool], ["$exists": true])
        
        let doesNotExist = SCOperator.DoesNotExist("fieldName")
        XCTAssertEqual(doesNotExist.dic as! [String : Bool], ["$exists": false])
        
        let contains = SCOperator.Contains("fieldName", "[0-9]", "x")
        XCTAssertEqual(contains.dic as! [String : String], ["$regex": "[0-9]", "$options": "x"])
        
        let startsWith = SCOperator.StartsWith("fieldName", "[0-9]", "x")
        XCTAssertEqual(startsWith.dic as! [String : String], ["$regex": "^[0-9]", "$options": "x"])
        
        let endsWith = SCOperator.EndsWith("fieldName", "[0-9]", "x")
        XCTAssertEqual(endsWith.dic as! [String : String], ["$regex": "[0-9]$", "$options": "x"])
        
        let or = SCOperator.Or([greaterThan, lessThan])
        XCTAssertEqual(or.dic as! [NSDictionary], [["fieldName": ["$gt": 5]], ["fieldName": ["$lt": 5]]])
        
        let and = SCOperator.And([greaterThan, lessThan])
        XCTAssertEqual(and.dic as! [NSDictionary], [["fieldName": ["$gt": 5]], ["fieldName": ["$lt": 5]]])
    }
    
    func testExpression() {
        
        let equalTo = SCOperator.EqualTo("fieldName", SCString("A"))
        XCTAssertEqual((equalTo.expression) as! [String : String], ["fieldName": "A"])
        
        let notEqualTo = SCOperator.NotEqualTo("fieldName", SCBool(false))
        XCTAssertEqual(notEqualTo.expression as! [String : NSDictionary], ["fieldName": ["$ne": false]])
        
        let containedIn = SCOperator.ContainedIn("fieldName", SCArray([SCString("A"), SCString("B")]))
        XCTAssertEqual(containedIn.expression as! [String : NSDictionary], ["fieldName": ["$in": ["A", "B"]]])
        
        let containsAll = SCOperator.ContainsAll("fieldName", SCArray([SCString("A"), SCString("B")]))
        XCTAssertEqual(containsAll.expression as! [String : NSDictionary], ["fieldName": ["$all": ["A", "B"]]])
        
        let notContainedIn = SCOperator.NotContainedIn("fieldName", SCArray([SCString("A"), SCString("B")]))
        XCTAssertEqual(notContainedIn.expression as! [String : NSDictionary], ["fieldName": ["$nin": ["A", "B"]]])
        
        let greaterThan = SCOperator.GreaterThan("fieldName", SCInt(5))
        XCTAssertEqual(greaterThan.expression as! [String : NSDictionary], ["fieldName": ["$gt": 5]])
        
        let greaterThanOrEqualTo = SCOperator.GreaterThanOrEqualTo("fieldName", SCInt(5))
        XCTAssertEqual(greaterThanOrEqualTo.expression as! [String : NSDictionary], ["fieldName": ["$gte": 5]])
        
        let lessThan = SCOperator.LessThan("fieldName", SCInt(5))
        XCTAssertEqual(lessThan.expression as! [String : NSDictionary], ["fieldName": ["$lt": 5]])
        
        let lessThanOrEqualTo = SCOperator.LessThanOrEqualTo("fieldName", SCInt(5))
        XCTAssertEqual(lessThanOrEqualTo.expression as! [String : NSDictionary], ["fieldName": ["$lte": 5]])
        
        let exists = SCOperator.Exists("fieldName")
        XCTAssertEqual(exists.expression as! [String : NSDictionary], ["fieldName": ["$exists": true]])
        
        let doesNotExist = SCOperator.DoesNotExist("fieldName")
        XCTAssertEqual(doesNotExist.expression as! [String : NSDictionary], ["fieldName": ["$exists": false]])
        
        let contains = SCOperator.Contains("fieldName", "[0-9]", "x")
        XCTAssertEqual(contains.expression as! [String : NSDictionary], ["fieldName": ["$regex": "[0-9]", "$options": "x"]])
        
        let startsWith = SCOperator.StartsWith("fieldName", "[0-9]", "x")
        XCTAssertEqual(startsWith.expression as! [String : NSDictionary], ["fieldName": ["$regex": "^[0-9]", "$options": "x"]])
        
        let endsWith = SCOperator.EndsWith("fieldName", "[0-9]", "x")
        XCTAssertEqual(endsWith.expression as! [String : NSDictionary], ["fieldName": ["$regex": "[0-9]$", "$options": "x"]])
     
        let or = SCOperator.Or([greaterThan, lessThan])
        XCTAssertEqual(or.expression as! [String : NSArray], ["$or" : [["fieldName": ["$gt": 5]], ["fieldName": ["$lt": 5]]]])

        let and = SCOperator.And([greaterThan, lessThan])
        XCTAssertEqual(and.expression as! [String : NSArray], ["$and" : [["fieldName": ["$gt": 5]], ["fieldName": ["$lt": 5]]]])
    }
    
}
