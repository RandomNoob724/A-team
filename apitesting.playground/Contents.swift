import UIKit

struct image : Codable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let download_url: String
}

var allImages: [image] = []

class RestHandler {
    
    static func fetchDog(completion: ((Bool) -> Void)?) {
        // This is the API: https://dog.ceo/dog-api/
        guard let url = URL(string: "https://picsum.photos/id/0/info") else {
            // If the url object is nil we'll send false through the callback and end the function.
            completion?(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET" // Most common methods: GET, POST, PUT, DELETE
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        // The dataTask functions has a callback with these parameters (Data?, URLResponse?, Error?)
        let task = session.dataTask(with: url) { (responseData, response, responseError) in
            let decoder = JSONDecoder()
            print(String(data: responseData!, encoding: .ascii)!)
            if let data = responseData, let backgroundImage = try? decoder.decode(image.self, from: data) {
                allImages.append(backgroundImage)
            }
            
            // A callback always needs to be called so the the class calling this function gets a response
            // But make sure that the callback is only called once otherwise the app will crash
            completion?(false)
        }
        
        task.resume()
    }
}
RestHandler.fetchDog(completion: {(success) in
    if success{
        for i in allImages{
            print("\n\(i)")
        }
    }
})
