//
//  CarsAPITests.swift
//  ViperPracTests
//
//  Created by USER on 2021/02/05.
//

import XCTest

@testable import ViperPrac

class CarsAPITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    /*
     만약 이 경우에는 외부 모듈(Alamofire, Moya에 의존하고 있을 경우 문제가 발생한다.)
     */
    func testRequestCars() {
        // given
        let expectation = XCTestExpectation(description: "Request is Completed")
        let carsAPIService = CarsAPIService()
        var requestedCars: [Car]?
        var someError: NSError?
        
        // when
        carsAPIService.requestCars { cars, error in
            requestedCars = cars
            someError = error
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
        
        // then
        XCTAssertNil(someError, "Erorr was not occured")
        XCTAssertNotNil(requestedCars, "Complete Request")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
