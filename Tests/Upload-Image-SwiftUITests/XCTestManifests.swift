import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(Upload_Image_SwiftUITests.allTests),
    ]
}
#endif
