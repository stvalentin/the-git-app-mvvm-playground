import XCTest
@testable import TheGitApp

class RepositoryListViewModelTest: XCTestCase {
    
    func testViewModel() throws {
        let apiClient = MockClient(successfull: true)
        let viewModel = RepositoryListViewModel(apiClient: apiClient)

        let callbackExpectation = expectation(description: "Api finished retrieving information")

        viewModel.resultFetched = {
            callbackExpectation.fulfill()
        }
        
        viewModel.fetch(searchQuery: "Anything")
        
        XCTAssertEqual(viewModel.list.count, 30)
        XCTAssertEqual(viewModel.numberOfItems, 30)
        waitForExpectations(timeout: 1.0)
    }
    
    func testFailsViewModel() throws {
        let apiClient = MockClient(successfull: false)
        let viewModel = RepositoryListViewModel(apiClient: apiClient)

        let callbackExpectation = expectation(description: "Api finished retrieving information")
        callbackExpectation.isInverted = true
        
        viewModel.resultFetched = {
            callbackExpectation.fulfill()
        }
        
        viewModel.fetch(searchQuery: "Anything")
        
        XCTAssertEqual(viewModel.list.count, 0)
        XCTAssertEqual(viewModel.numberOfItems, 0)
        waitForExpectations(timeout: 1.0)
    }
}


