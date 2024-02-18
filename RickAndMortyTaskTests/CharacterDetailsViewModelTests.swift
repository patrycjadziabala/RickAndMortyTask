//
//  CharacterDetailsViewModelTests.swift
//  RickAndMortyTaskTests
//
//  Created by Patka on 18/02/2024.
//

import XCTest
@testable import RickAndMortyTask

final class CharacterDetailsViewModelTests: XCTestCase {
    var sut: CharacterDetailsViewModel!
    
    override func setUpWithError() throws {
        sut = CharacterDetailsViewModel(character: Character(id: 123, name: "", status: "", gender: "", origin: OriginModel(name: "", url: ""), location: LocationModel(name: "", url: ""), image: "", episode: []))
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testGetEpisodeNumberFromEpisodeUrlSuccess() {
        //given
        let url = "https://rickandmortyapi.com/api/episode/28"
        
        //when
        let expectedResult = sut.getEpisodeNumberFromEpisodeUrl(url: url)
        
        //then
        XCTAssertEqual(expectedResult, 28)
    }
    
    func testGetEpisodeNumberFromEpisodeUrlFailure() {
        //given
        let url = "https://rickandmortyapi.com/api/episode/abc"
        
        //when
        let expectedResult = sut.getEpisodeNumberFromEpisodeUrl(url: url)
        
        //then
        XCTAssertNil(expectedResult)
    }
    
    func testGetEpisodeNumberStringSuccess() {
        //given
       let url =  "https://rickandmortyapi.com/api/episode/28"
        
        //when
        let expectedResult = sut.getEpisodeNumberString(url: url)
        
        //then
        XCTAssertEqual(expectedResult, "28")
    }
    
    func testGetEpisodeNumberStringFailure() {
        //given
        let url =  "https://rickandmortyapi.com/api/episode/abc"
        
        //when
        let expectedResult = sut.getEpisodeNumberString(url: url)
        
        //then
        XCTAssertNil(expectedResult)
    }
}
