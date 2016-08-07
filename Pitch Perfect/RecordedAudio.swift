 //
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Amelia Boli on 3/20/16.
//  Copyright © 2016 Amelia Boli. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl: NSURL?, title: String?) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}