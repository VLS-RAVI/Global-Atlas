//
//  CountryListTests.swift
//  Global AtlasTests
//
//  Created by V L S RAVI on 21/04/24.
//

import XCTest
@testable import Global_Atlas

class CountryListTests: XCTestCase {
    
    //MARK: System under test
    var sut: CountryListViewModel!
    var mockService: MockCountryListService!

    //MARK: Setup
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        //Setup required for SUT  i.e VM
        mockService = MockCountryListService()
        
        sut = CountryListViewModel(usecase: mockService)
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
    func testFetchCountriesSuccess() throws {
        //given
        mockService.status = .success
        
        //when
        sut.fetchCountries()
        
        //then
        XCTAssert(sut.searchedCountries.count > 0, "Parse response Failed")

    }
    
    //failure response
    func testFetchCoinsFailure() throws {
        //given
        mockService.status = .error
        
        //when
        sut.fetchCountries()
        
        //then
        XCTAssertEqual(sut.searchedCountries.count, 0)
    }
    
}

