
import Foundation

struct GitItem:Codable {
    let id: Int
    let nodeId:String
    let name:String
    let forksCount:Int
    let description:String?
    let language:String?
    let htmlUrl:String
    let createdAt:String
    let owner:Owner?
    
 
}

struct Owner:Codable {
    let avatarUrl:String?
    
    
}

extension GitItem {
    
    func formattedDate()->String {
           
           let dateFormatter = DateFormatter()
           let tempLocale = dateFormatter.locale // save locale temporarily
           dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
           dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
           let date = dateFormatter.date(from: createdAt)!
           dateFormatter.dateFormat = "dd-MM-yyyy"
           dateFormatter.locale = tempLocale // reset the locale
           let dateString = dateFormatter.string(from: date)
           return dateString
           
       }
    
}




