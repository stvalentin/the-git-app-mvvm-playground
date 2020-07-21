import XCTest
@testable import TheGitApp

class RepositoryListViewModelTest: XCTestCase {
    
    func testViewModel() throws {
        let apiClient = MockClient(successfull: true)
        let viewModel = RepositoryListViewModel(apiClient: apiClient)

        let callbackExpectation = expectation(description: "Api finished retrieving information")

        viewModel.items.bind({ items in
            guard let items = items else {
                return
            }
            callbackExpectation.fulfill()
        })
        viewModel.fetch(searchQuery: "Anything")
        
        XCTAssertEqual(viewModel.items.value?.items.count, 30)
        waitForExpectations(timeout: 1.0)
    }
    
    func testFailsViewModel() throws {
        let apiClient = MockClient(successfull: false)
        let viewModel = RepositoryListViewModel(apiClient: apiClient)

        let callbackExpectation = expectation(description: "Api finished retrieving information")
        callbackExpectation.isInverted = true
        
        viewModel.items.bind({ items in
            guard let items = items else {
                return
            }
            callbackExpectation.fulfill()
        })
        viewModel.fetch(searchQuery: "Anything")
        
        XCTAssertEqual(viewModel.items.value?.items.count, Optional(nil))
        XCTAssertEqual(viewModel.error.value, ErrorResult.invalidData)
        waitForExpectations(timeout: 1.0)
    }
}


