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

protocol ApiProtocol {
    func getSearchRequest(searchQuery: String, completion: @escaping (SearchResults?) -> Void)
    func getReadmeRequest(repository: Repository, completion: @escaping(String?) -> Void)
}

class ApiClient: ApiProtocol {
    
    private var queue: DispatchQueue
    private let baseUrl = "https://api.github.com/search/repositories?q=android&sort=stars&order=desc"
    
    init() {
        self.queue = DispatchQueue(label: "com.thegitapp.api", qos: .background, attributes: .concurrent)
    }
    
    
    func getSearchRequest(searchQuery: String, completion: @escaping (SearchResults?) -> Void) {
        
        AF.request(baseUrl)
            .responseDecodable(queue: self.queue) { (response: DataResponse<SearchResults, AFError>) in
            completion(response.value)
        }
    }
    
    func getReadmeRequest(repository: Repository, completion: @escaping(String?) -> Void) {
        
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

class MockClient: ApiProtocol {
    private let successfull: Bool
    
    init(successfull: Bool) {
        self.successfull = successfull
    }

    func getSearchRequest(searchQuery: String, completion: @escaping (SearchResults?) -> Void) {
        let filePath = "repositories"
        if !successfull {
            completion(nil)
            return
        }
            
        MockClient.loadJsonDataFromFile(filePath, completion: { data in
            if let json = data {
                do {
                    let repositories = try JSONDecoder().decode(SearchResults.self, from: json)
                    completion(repositories)
                }
                catch _ as NSError {
                    fatalError("Couldn't load data from \(filePath)")
                }
            }
        })
    }
    
    private static func loadJsonDataFromFile(_ path: String, completion: (Data?) -> Void) {
        if let fileUrl = Bundle.main.url(forResource: path, withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileUrl, options: [])
                completion(data as Data)
            } catch (let error) {
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func getReadmeRequest(repository: Repository, completion: @escaping (String?) -> Void) {
        if successfull {
            completion("Complete")
        } else {
            completion(nil)
        }
    }
}
