import Foundation

class APIConsumer {
    private var baseSearchURL = "https://api.giphy.com/v1/gifs/search?q=seinfeld"
    private var apiKey = "&api_key=dc6zaTOxFJmzC"
    
    internal var jsonResponse: [String: Any]?
    
    public func findAllGifs(url: URL? = nil, completion: @escaping ([Gif]) -> Void) {
        let url = url != nil ? url : URL(string: "\(baseSearchURL)\(apiKey)")
        let request = URLRequest(url: url!)
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, error) in
            var gifData = [Gif]()
            //add pagination
            if error != nil {
                print(error!.localizedDescription)
            } else {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                        self.jsonResponse = json
                        let gifItems = self.jsonResponse?["data"] as! [[String: Any]]
                        
                        for response in gifItems {
                            let id = response["id"] as! String
                            let embed_url = response["embed_url"] as! String
                            var url = ""
                            if let images = response["images"] as? [String:Any], let fixedHeight = images["fixed_height"] as? [String:Any] {
                                url = fixedHeight["url"] as! String
                            }
                            
                            let slug = response["slug"] as! String
                            
                            if slug.lowercased().range(of:"seinfeld") != nil {
                                let gif = Gif(id: id, embed_url: embed_url, url: url, slug: slug)
                                gifData.append(gif)
                            }
                        }
                    }
                } catch {
                    print("error in JSONSerialization")
                }
            }
            completion(gifData)
        })
        task.resume()
        
    } //end findAllGifs
    
    public func searchGifs(searchTerm: String, completion: @escaping ([Gif]) -> Void) {
        print("search")
        let url = URL(string: "\(baseSearchURL)+\(searchTerm)\(apiKey)")
        let request = URLRequest(url: url!)
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, error) in
            var gifData = [Gif]()
            //add pagination
            if error != nil {
                print(error!.localizedDescription)
            } else {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                        self.jsonResponse = json
                        let gifItems = self.jsonResponse?["data"] as! [[String: Any]]
                        
                        for response in gifItems {
                            let id = response["id"] as! String
                            let embed_url = response["embed_url"] as! String
                            var url = ""
                            if let images = response["images"] as? [String:Any], let fixedHeight = images["fixed_height"] as? [String:Any] {
                                url = fixedHeight["url"] as! String
                            }
                            
                            let slug = response["slug"] as! String
                            
                            //check for seinfeld tag
                            if slug.lowercased().range(of:"seinfeld") != nil {
                                let gif = Gif(id: id, embed_url: embed_url, url: url, slug: slug)
                                gifData.append(gif)
                            }
                        }
                    }
                } catch {
                    print("error in JSONSerialization")
                }
            }
            completion(gifData)
        })
        task.resume()
    }
    
} //end APIConsumer class

