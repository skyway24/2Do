//
//  ThemeSettings.swift
//  2Do
//
//  Created by Akash Verma on 27/05/21.
//

import SwiftUI

class ThemeSettings: ObservableObject{
    
    @Published var themeSettings: Int = UserDefaults.standard.integer(forKey: "Theme"){
        didSet{
            UserDefaults.standard.set(self.themeSettings, forKey: "Themes")
        }
        
    }
    
}
