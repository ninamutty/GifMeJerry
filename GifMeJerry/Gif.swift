import Foundation

class Gif {
    public var id: String
    public var embed_url: String
    public var url: String
    public var slug: String
//    public var height: String
//    public var width: String
//    public var fixedHeightURL: URL
    
    init(id: String, embed_url: String, url: String, slug: String) {
        self.id = id
        self.embed_url = embed_url
        self.url = url
        self.slug = slug
//        self.height = height
//        self.width = width
//        self.fixedHeightURL = fixedHeightURL
    }
}
