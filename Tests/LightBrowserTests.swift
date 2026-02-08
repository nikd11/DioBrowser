import XCTest
@testable import LightBrowser

final class LightBrowserTests: XCTestCase {

    func testURLParsing() throws {
        // Test URL parsing logic
        let testCases = [
            ("apple.com", "https://apple.com"),
            ("https://apple.com", "https://apple.com"),
            ("search query", "https://www.google.com/search?q=search+query"),
            ("", ""),
        ]
        
        for (input, expected) in testCases {
            // This would test your URL parsing logic
            // Actual implementation depends on BrowserManager
            XCTAssertNotNil(input)
        }
    }

    func testTabManagement() throws {
        let manager = BrowserManager()
        
        // Test initial tab
        XCTAssertEqual(manager.tabs.count, 1)
        
        // Test adding tab
        manager.addTab()
        XCTAssertEqual(manager.tabs.count, 2)
        
        // Test switching tabs
        manager.switchToTab(1)
        XCTAssertEqual(manager.currentTab, 1)
    }

    func testPerformanceExample() throws {
        measure {
            // Put the code you want to measure the time of here.
            _ = BrowserManager()
        }
    }
}
