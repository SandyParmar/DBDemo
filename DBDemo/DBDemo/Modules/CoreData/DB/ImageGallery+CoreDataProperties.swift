//
//  ImageGallery+CoreDataProperties.swift
//  
//
//  Created by Sandeep Parmar on 26/11/19.
//
//

import Foundation
import CoreData


extension ImageGallery {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageGallery> {
        return NSFetchRequest<ImageGallery>(entityName: "ImageGallery")
    }

    @NSManaged public var albumId: Int64
    @NSManaged public var id: Int64
    @NSManaged public var thumbnailUrl: String?
    @NSManaged public var url: String?
    @NSManaged public var title: String?

}
