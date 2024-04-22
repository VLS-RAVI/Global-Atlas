//
//  CountryDetailsTests.swift
//  Global AtlasTests
//
//  Created by V L S RAVI on 21/04/24.
//

import XCTest
@testable import Global_Atlas

class CountryDetailsTests: XCTestCase {
    
    //MARK: System under test
    var sut: CountryDetailsViewModel!
    var mockService: MockCountryDetailsService!

    //MARK: Setup
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        //Setup required for SUT  i.e VM
        mockService = MockCountryDetailsService()
        
        sut = CountryDetailsViewModel(usecase: mockService, countryName: "India", countryCode: "Ind")
    }
    
    //MARK: Teardown
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        mockService = nil
    
        try super.tearDownWithError()
    }

    //MARK: API Response Functionality Tests
    //success response
    func testFetchCoinsSuccess() throws {
        //given
        mockService.status = .success
        
        //when
        sut.fetchCountryDetails()
        
        //then
        XCTAssert(sut.country?.name == "India", "Parse response Failed")
        XCTAssert(sut.country?.capital == "New Delhi", "Parse response Failed - capital")
    }
    
    //failure response
    func testFetchCoinsFailure() throws {
        //given
        mockService.status = .error
        
        //when
        sut.fetchCountryDetails()
        
        //then
        XCTAssertNil(sut.country)
    }
}
