//
//  PhotoInfo.swift
//  AstroPic
//
//  Created by Guillermo Chumaceiro on 26/7/22.
//

import Foundation

struct PhotoInfo: Codable {

    var title: String
    var description: String
    var url: URL?
    var copyright: String?
    var date: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "explanation"
        case url = "url"
        case copyright = "copyright"
        case date = "date"
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try valueContainer.decode(String.self, forKey: CodingKeys.title)
        self.description = try valueContainer.decode(String.self, forKey: CodingKeys.description)
        self.url = try valueContainer.decode(URL.self, forKey: CodingKeys.url)
        self.copyright = try? valueContainer.decode(String.self, forKey: CodingKeys.copyright)
        self.date = try valueContainer.decode(String.self, forKey: CodingKeys.date)
    }
    
    init() {
        self.description = ""
        self.title = ""
        self.date = ""
    }
    
    static func createDefault() -> PhotoInfo {
        var photoInfo = PhotoInfo()
        
        photoInfo.title = "Find the New Moon"
        photoInfo.description = "Can you find the Moon? This usually simple task can be quite difficult.  Even though the Moon is above your horizon half of the time, its phase can be anything from crescent to full. The featured image was taken in late May from Sant Martí d'Empúries, Spain, over the Mediterranean Sea in the early morning. One reason you can't find this moon is because it is very near to its new phase, when very little of the half illuminated by the Sun is visible to the Earth. Another reason is because this moon is near the horizon and so seen through a long path of Earth's atmosphere -- a path which dims the already faint crescent. Any crescent moon is only visible near the direction the Sun, and so only locatable near sunrise of sunset. The Moon runs through all of its phases in a month (moon-th), and this month the thinnest sliver of a crescent -- a new moon -- will occur in three days."
        
        photoInfo.date = "2022-07-25"
        return photoInfo
    }
}
