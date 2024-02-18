//
//  CharactersListViewModelTests.swift
//  RickAndMortyTaskTests
//
//  Created by Patka on 18/02/2024.
//

import XCTest
@testable import RickAndMortyTask

@MainActor final class CharactersListViewModelTests: XCTestCase {
    var sut: CharactersListViewModel!
    var mockApiManager: MockApiManager!
    
    override func setUpWithError() throws {
        mockApiManager = MockApiManager()
        sut = CharactersListViewModel(apiManager: mockApiManager)
    }
    
    override func tearDownWithError() throws {
        mockApiManager = nil
        sut = nil
    }
    
    func testFetchNextPageCharactersSuccess() async {
        //given
        let firstPageCharacters = [Character(id: 123,
                                    name: "",
                                    status: "",
                                    gender: "",
                                    origin: OriginModel(
                                        name: "",
                                        url: ""),
                                    location: LocationModel(
                                        name: "",
                                        url: ""),
                                    image: "",
                                    episode: [])]
        let firstPageMockResponse = APIModel(info: InfoModel(next: "secondPage",
                                                    prev: ""),
                                    results: firstPageCharacters)
        let secondPageCharacters = [Character(id: 1234,
                                    name: "",
                                    status: "",
                                    gender: "",
                                    origin: OriginModel(
                                        name: "",
                                        url: ""),
                                    location: LocationModel(
                                        name: "",
                                        url: ""),
                                    image: "",
                                    episode: [])]
        let secondPageMockResponse = APIModel(info: InfoModel(next: "thirdPage",
                                                    prev: ""),
                                    results: secondPageCharacters)
        mockApiManager.expectedApiModelFromEndpoint = firstPageMockResponse
        mockApiManager.expectedApiModelFromUrl = secondPageMockResponse

        //when
        do {
            try await sut.fetchFirstPageIfNeeded()
            try await sut.fetchNextPageCharacters()
        } catch {
            XCTFail()
        }
        
        //then
        XCTAssertEqual(mockApiManager.urlsCalled, ["secondPage"])
        var expectedCharactersList: [Character] = []
        expectedCharactersList.append(contentsOf: firstPageCharacters)
        expectedCharactersList.append(contentsOf: secondPageCharacters)
        XCTAssertEqual(sut.charactersList, expectedCharactersList)
    }
    
    func testFetchNextPageCharactersFailure() async {
        //given
        let firstPageCharacters = [Character(id: 123,
                                    name: "",
                                    status: "",
                                    gender: "",
                                    origin: OriginModel(
                                        name: "",
                                        url: ""),
                                    location: LocationModel(
                                        name: "",
                                        url: ""),
                                    image: "",
                                    episode: [])]
        let firstPageMockResponse = APIModel(info: InfoModel(next: "secondPage",
                                                    prev: ""),
                                    results: firstPageCharacters)
       
        mockApiManager.expectedApiModelFromEndpoint = firstPageMockResponse
        let secondRequestError = MockApiManagerError.genericError
        mockApiManager.apiModelErrorFromUrl = secondRequestError

        //when
        var assertedError: MockApiManagerError?
        do {
            try await sut.fetchFirstPageIfNeeded()
            try await sut.fetchNextPageCharacters()
        } catch {
            assertedError = error as? MockApiManagerError
        }
        
        //then
        XCTAssertEqual(assertedError, secondRequestError)
        XCTAssertEqual(mockApiManager.urlsCalled, ["secondPage"])
        XCTAssertEqual(firstPageCharacters, sut.charactersList)

    }
    
    func testFirstPageIfNeededSuccess() async {
        //given
        let characters = [Character(id: 123,
                                    name: "",
                                    status: "",
                                    gender: "",
                                    origin: OriginModel(
                                        name: "",
                                        url: ""),
                                    location: LocationModel(
                                        name: "",
                                        url: ""),
                                    image: "",
                                    episode: [])]
        let mockResponse = APIModel(info: InfoModel(next: "nextPage",
                                                    prev: ""),
                                    results: characters)
        mockApiManager.expectedApiModelFromEndpoint = mockResponse
        
        //when
        do {
            try await sut.fetchFirstPageIfNeeded()
        } catch {
            XCTFail()
        }
       
        //then
        XCTAssertEqual(sut.charactersList, characters)
    }
    
    func testFirstPageIfNeededFailure() async {
        //given
        let mockError = MockApiManagerError.genericError
        mockApiManager.apiModelError = mockError
        
        //when
        var assertedError: MockApiManagerError?
        do {
            try await sut.fetchFirstPageIfNeeded()
        } catch {
            assertedError = error as? MockApiManagerError
        }
        
        //when
        XCTAssertEqual(mockError, assertedError)
    }
    
    func testisCharacterLastInAlreadyFetched() {
        //given
        let modelFirst = Character(id: 123,
                              name: "",
                              status: "",
                              gender: "",
                              origin: OriginModel(name: "", url: ""),
                              location: LocationModel(name: "", url: ""),
                              image: "",
                              episode: [])
        let modelSecond = Character(id: 12345,
                              name: "",
                              status: "",
                              gender: "",
                              origin: OriginModel(name: "", url: ""),
                              location: LocationModel(name: "", url: ""),
                              image: "",
                              episode: [])
        sut.charactersList = [modelFirst, modelSecond]
        
        //when
        let firstBool = sut.isCharacterLastInAlreadyFetched(character: modelFirst)
        let secondBool = sut.isCharacterLastInAlreadyFetched(character: modelSecond)
        
        //then
        XCTAssertFalse(firstBool)
        XCTAssertTrue(secondBool)
    }
}
