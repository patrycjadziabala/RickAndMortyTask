//
//  EpisodeDetailsViewModelTests.swift
//  RickAndMortyTaskTests
//
//  Created by Patka on 18/02/2024.
//

import XCTest
@testable import RickAndMortyTask

final class EpisodeDetailsViewModelTests: XCTestCase {
    
    var sut: EpisodeDetailsViewModel!
    var mockApiManager: MockApiManager!
    
    override func setUpWithError() throws {
        mockApiManager = MockApiManager()
        sut = EpisodeDetailsViewModel(apiManager: mockApiManager)
    }
    
    override func tearDownWithError() throws {
        mockApiManager = nil
        sut = nil
    }
    
    func testFetchEpisodeInfoSuccess() async {
        //given
        let episodeModel = EpisodeModel(id: 123, name: "", air_date: "", episode: "", characters: [])
        mockApiManager.expectedEpisodeModel = episodeModel
        
        //when
        do {
            try await sut.fetchEpisodeInfo(episodeId: "123")
        } catch {
            XCTFail()
        }
        
        //then
        XCTAssertEqual(sut.episode, episodeModel)
    }
    
    func testFetchEpisodeInfoFailure() async {
        //given
        let mockError = MockApiManagerError.genericError
        mockApiManager.apiModelError = mockError
        
        //when
        var assertedError: MockApiManagerError?
        do {
            try await sut.fetchEpisodeInfo(episodeId: "123")
        } catch {
            assertedError = error as? MockApiManagerError
        }
        
        //when
        XCTAssertEqual(mockError, assertedError)
    }
    
    func testGetNumberOfCharactersInEpisode() {
        //given
        sut.episode = EpisodeModel(id: 1, name: "", air_date: "", episode: "", characters: ["123","3242","1234"])
        
        //when
       let numberOfCharacters =  sut.getNumberOfCharactersInEpisode()
        
        //then
        XCTAssertEqual(numberOfCharacters, 3)
    }
}
