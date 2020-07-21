import XCTest
@testable import TheGitApp

class RepositoryDetailViewModelTests: XCTestCase {
    func testViewModel() throws {

        let mockClient = MockClient(successfull: true)
        let stub = Repository.stub()
        let viewModel = RepositoryDetailViewModel(apiClient: mockClient, repository: stub)
        
        let callbackExpectation = expectation(description: "Finished Api request")

        viewModel.readmeContent.bind({ item in
            guard let item = item else {
                return
            }
            callbackExpectation.fulfill()
        })
        
        viewModel.fetch()
            
        XCTAssertNotNil(viewModel.readmeContent)
        waitForExpectations(timeout: 2.0);
    }
    
    func testRequestsFailsViewModel() throws {

        let mockClient = MockClient(successfull: false)
        let stub = Repository.stub()
        let viewModel = RepositoryDetailViewModel(apiClient: mockClient, repository: stub)
        
        let callbackExpectation = expectation(description: "Finished Api request")
        
        viewModel.readmeContent.bind({ item in
            guard let item = item else {
                return
            }
            callbackExpectation.fulfill()
        })
        
        viewModel.fetch()
    
        waitForExpectations(timeout: 2.0);
    }
}
