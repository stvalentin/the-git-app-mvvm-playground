import Foundation

extension Repository {
    static func stub(
        name: String = "Name",
        description: String? = "Description",
        updatedAt: String = "updatedAt",
        createdAt: String = "createdAt",
        forksCount: Int = 12,
        watchersCount: Int = 13,
        owner: Owner = Owner(login: "LoginName"),
        htmlUri: String = "http://www.foo.com",
        apiUrl: String = "http://www.foo.com"
    ) -> Self {
        return Repository(apiUrl: apiUrl,
                          createdAt: createdAt,
                          description: description,
                          forksCount: forksCount,
                          htmlUrl: htmlUri,
                          name: name,
                          owner: owner,
                          updatedAt: updatedAt,
                          watchersCount: watchersCount)
    }
}
