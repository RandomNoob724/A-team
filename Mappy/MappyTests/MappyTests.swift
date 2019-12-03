//
//  MappyTests.swift
//  MappyTests
//
//  Created by Ulf Jesper Isacson on 2019-12-03.
//  Copyright © 2019 Emil Persson. All rights reserved.
//
import Foundation
import XCTest
import CoreLocation
@testable import Mappy

class MappyTests: XCTestCase {

    
    func testCreateEvent()
    {
        let newEvent = Event(title: "SexKreation", description: "Shit's lit")
        XCTAssertEqual(newEvent.title, "SexKreation")
        XCTAssertEqual(newEvent.eventDescription, "Shit's lit")
    }
    
    func testInsertNewEvent()
    {
        let newEvent = Event()
        let nrOfEvents = EventHandler.instance.allEvents.count
        EventHandler.instance.insertNewEvent(newEvent: newEvent)
        XCTAssertTrue(EventHandler.instance.allEvents.count > nrOfEvents)
    }
    
    func testSetNewTitle()
    {
        let event = Event(title: "Julbak hos Gabbe")
        event.setTitle(newTitle: "Julbak hos Emil")
        XCTAssertEqual(event.title, "Julbak hos Emil")
    }
    
    func testUpdateCoordinates()
    {
        let coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
        var event = Event(coordinates: coordinates)
        let newCoordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 34.21, longitude: 48.40)
        event.updateCoordinates(newCoordinates: newCoordinates)
        XCTAssertTrue(event.coordinate.latitude != coordinates.latitude)
        XCTAssertTrue(event.coordinate.longitude != coordinates.longitude)
    }
    
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
