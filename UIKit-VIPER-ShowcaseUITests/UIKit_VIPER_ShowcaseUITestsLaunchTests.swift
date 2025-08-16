//
//  UIKit_VIPER_ShowcaseUITestsLaunchTests.swift
//  UIKit-VIPER-ShowcaseUITests
//
//  Created by Emre GEMİCİ on 16.08.2025.
//

import XCTest

final class UIKit_VIPER_ShowcaseUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
