import Foundation

class RepositoryListViewModel {

    private var apiClient: ApiProtocol
    
    private var currentPage: Int =  0
    private var totalPageCount: Int = 1
    private var hasMorePages: Bool {
        currentPage < totalPageCount
    }
    private var nextPage: Int { hasMorePages  ? currentPage + 1: currentPage}
    
    var items = Box<SearchResults?>(nil)
    var error = Box<ErrorResult?>(nil)
    var searchText = Box<String?>("Android")
    
    var isFetchInProgress = Box<Bool>(false)
        
    var selectedRepository: Repository?
    
    init(apiClient: ApiProtocol) {
        self.apiClient = apiClient;
        //self.viewModel?.items.bind({ items in
        
        self.searchText.bind({ text in
            guard let text = text else {
                return
            }
            self.fetch()
        })
    }
    
    func fetch() {
        resetPages()
        willLoadNextPage()
    }
    
    func willLoadNextPage() {
        guard let searchQuery = searchText.value else  {
            return
        }
        
        if searchQuery.isEmpty {
            return
        }
        
        guard !isFetchInProgress.value else {
            return
        }
        isFetchInProgress.value = true
        
        self.apiClient.getSearchRequest(searchQuery: searchQuery, page: nextPage) { result in
            self.isFetchInProgress.value = false
            switch result {
            case .success(let result):
                self.appendPage(result: result)
            case .failure(let error):
                self.error.value = error
            }
        }
    }
    
    func appendPage(result: SearchResults) {
        let resultValue = self.items.value?.items  ?? []
        totalPageCount = result.totalCount
        let arr = resultValue + result.items
        
        self.items.value = SearchResults(totalCount: result.totalCount, incompleteResults: result.incompleteResults, items: arr)
        
        currentPage += 1
    }
    
    func resetPages() {
        currentPage =  0
        totalPageCount = 1
        self.items.value =  SearchResults(
            totalCount: 0,
            incompleteResults: true,
            items: []
        )
    }
}
