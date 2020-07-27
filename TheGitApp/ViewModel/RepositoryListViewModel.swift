import Foundation

class RepositoryListViewModel {

    private var apiClient: ApiProtocol
    var items = Box<SearchResults?>(nil)
    var error = Box<ErrorResult?>(nil)
    var searchText = Box<String?>("Android")
    
        
    var selectedRepository: Repository?
    
    init(apiClient: ApiProtocol) {
        self.apiClient = apiClient;
        //self.viewModel?.items.bind({ items in
        
        
        self.searchText.bind({ text in
            guard let text = text else {
                return
            }
            self.fetch(searchQuery: text)
        })
    }
    
    func fetch(searchQuery: String) {
        if searchQuery.isEmpty {
            return
        }
        
        self.apiClient.getSearchRequest(searchQuery: searchQuery) { result in
            switch result {
            case .success(let result):
                self.items.value = result
            case .failure(let error):
                self.error.value = error
            }
        }
    }
}
