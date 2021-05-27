//
//  SettingsView.swift
//  2Do
//
//  Created by Akash Verma on 27/05/21.
//

import SwiftUI

struct SettingsView: View {
    
    
    @Environment(\.presentationMode) var presentationMode
    
    
    let themes: [Theme] = themeData
    @ObservedObject var theme = ThemeSettings()
    @State private var isThemeChanged: Bool = false
    
    var body: some View {
        
        NavigationView{
            VStack(alignment: .center, spacing: 0){
                
                Form{
                    
                    
                    Section(header:
                                HStack{
                                    Text("Choose the app theme")
                                    Image(systemName: "circle.fill").resizable().frame(width: 10, height:10).foregroundColor(themes[self.theme.themeSettings].themeColor)
                                    
                                }
                    ) {
                        ForEach(themes, id: \.id){ item in
                            
                            
                            Button(action: {
                                
                                self.theme.themeSettings = item.id
                                
                                UserDefaults.standard.set(self.theme.themeSettings, forKey: "Theme")
                                self.isThemeChanged.toggle()
                            }){
                                
                                HStack{
                                    Image(systemName: "circle.fill").foregroundColor(item.themeColor)
                                    
                                    Text(item.themeName)
                                }
                                
                            }.accentColor(Color.primary)
                            
                        }
                        
                    }.padding(.vertical, 3)
                    .alert(isPresented: $isThemeChanged) {
                        Alert(
                            title: Text("Success!"),
                            message: Text("App has been changed to  \(themes[self.theme.themeSettings].themeName). Now Close and restart it!"),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    
                    Section(header: Text("Follow us on social media")) {
                        FormRowLinkView(icon: "globe", color: Color.pink, text: "Website", link: "https://github.com/Akashverma247")
                        
                        FormRowLinkView(icon: "link", color: Color.blue, text: "Twitter", link: "https://twitter.com/Akash_2_4")
                        
                        FormRowLinkView(icon: "link", color: Color.black, text: "GitHub", link: "https://github.com/Akashverma247")
                        
                    }.padding(.vertical, 3)
                    
                    Section(header: Text("About the application")) {
                        FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Todo")
                        
                        FormRowStaticView(icon: "checkmark.seal", firstText: "Compatibility", secondText: "iPhone, iPad")
                        
                        FormRowStaticView(icon: "keyboard", firstText: "Developer", secondText: "Akash")
                        
                        FormRowStaticView(icon: "paintbrush", firstText: "Designer", secondText: "Akash")
                        
                        FormRowStaticView(icon: "flag", firstText: "Version", secondText: "1.0.0")
                        
                        
                    }.padding(.vertical, 3)
                    
                    
                }.listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
                
                Text("Copyright © All rights reserved.\nBetter Apps ♡ Less Code")
                    .multilineTextAlignment(.center).font(.footnote).padding(.top, 6).padding(.bottom, 8).foregroundColor(Color.secondary)
            }.navigationBarItems(trailing: Button(action: {
                
                self.presentationMode.wrappedValue.dismiss()
                
            }){
                Image(systemName: "xmark")
            }
            )
            .navigationBarTitle("Settings",  displayMode: .inline)
            .background(Color("ColorBackground")).edgesIgnoringSafeArea(.all)
        }
        
        .accentColor(themes[self.theme.themeSettings].themeColor).navigationViewStyle(StackNavigationViewStyle())
    }
}



struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
