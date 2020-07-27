import Foundation
import Alamofire

extension Request {
   public func debugLog() -> Self {
      #if DEBUG
         debugPrint(self)
      #endif
      return self
   }
}

class ApiClient: ApiProtocol {    
    private var queue: DispatchQueue
    private let baseUrl = "https://api.github.com/search/repositories"
    
    init() {
        self.queue = DispatchQueue(label: "com.thegitapp.api", qos: .background, attributes: .concurrent)
    }
    
    func getSearchRequest(searchQuery: String, page: Int, completion: @escaping (Result<SearchResults, ErrorResult>) -> Void)  {
        
            let requestParameters: Parameters = [
                "q": searchQuery,
                "page": page,
                "sort": "stars",
                "order": "desc"
            ]

            AF.request(
                baseUrl, parameters: requestParameters
            )
            .responseDecodable(queue: self.queue) { (response: DataResponse<SearchResults, AFError>) in
    
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                switch(response.result) {
                case .success(let result):
                    completion(.success(result))
                case .failure(let error):
                    print(error)
                    completion(.failure(.invalidData))
                }
            }
    
        }
    }
    
    func getReadmeRequest(repository: Repository, completion: @escaping (String?) -> Void) {
        
        let urlStr = "https://api.github.com/repos/" + repository.apiUrl + "/readme"
        AF.request(urlStr)
            .responseDecodable(queue: self.queue) { (response: DataResponse<RepositoryReadMe, AFError>) in
            
            guard let downloadUrl = response.value?.downloadUrl else {
                completion(nil)
                return
            }
            
            AF.request(downloadUrl).response(queue: self.queue) { response in
                guard let data = try! response.result.get() else {
                    completion(nil)
                    return
                }
                completion(String(data: data, encoding: .utf8))
            }
        }
    }
}
