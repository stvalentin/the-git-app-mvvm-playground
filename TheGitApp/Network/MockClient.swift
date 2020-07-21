import Foundation

class MockClient: ApiProtocol {
    private let successfull: Bool
    
    init(successfull: Bool) {
        self.successfull = successfull
    }

    func getSearchRequest(searchQuery: String, completion: @escaping (Result<SearchResults, ErrorResult>) -> Void) {
        let filePath = "repositories"
        if !successfull {
            completion(.failure(.invalidData))
            return
        }
            
        MockClient.loadJsonDataFromFile(filePath, completion: { data in
            if let json = data {
                do {
                    let repositories = try JSONDecoder().decode(SearchResults.self, from: json)
                    completion(.success(repositories))
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
