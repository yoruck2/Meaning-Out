//
//  String+.swift
//  Meaning Out
//
//  Created by dopamint on 6/21/24.
//

import Foundation

extension String {
    
    // MARK: Initializers
    
    func removeHTMLTags() -> String? {
        guard let data = self.data(using: .utf8) else { return nil }
        
        let options: [NSAttributedString.DocumentReadingOptionKey:Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        guard let attributedString = try? NSAttributedString(data: data,
                                                             options: options,
                                                             documentAttributes: nil)
        else {
            return nil
        }
        return attributedString.string
    }
}
