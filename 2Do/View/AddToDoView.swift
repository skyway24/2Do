//
//  AddToDoView.swift
//  2Do
//
//  Created by Akash Verma on 23/05/21.
//

import SwiftUI

struct AddToDoView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage : String = ""
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    
    @ObservedObject var theme = ThemeSettings()
    var themes: [Theme] = themeData
    
    
    let priorities = ["High", "Normal", "Low"]
    var body: some View {
        
        
        NavigationView{
            VStack{
                VStack(alignment: .leading, spacing: 20){
                    TextField("ToDo", text: $name)
                        .padding().background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(9).font(.system(size: 24, weight: .bold, design: .default))
                    
                    Picker("Priority", selection: $priority){
                        ForEach(priorities, id: \.self){
                            Text($0)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    Button(action: {
                        if self.name != "" {
                            let todo = ToDo (context: self.managedObjectContext)
                            todo.name = self.name
                            todo.priority = priority
                            
                            do{
                                try self.managedObjectContext.save()
                            }catch {
                                print(error)
                            }
                        }
                        else{
                            self.errorShowing = true
                            self.errorTitle = "Invalid Name"
                            self.errorMessage = "Make sure to enter somethig for new ToDo item"
                            return
                        }
                        self.presentationMode.wrappedValue.dismiss()
                        
                    }){
                        Text("Save").font(.system(size: 24, weight: .bold, design: .default))
                            .padding().frame(minWidth: 0, maxWidth: .infinity)
                            .background(themes[self.theme.themeSettings].themeColor).cornerRadius(9).foregroundColor(Color.white)
                        
                    }
                    
                }.padding(.horizontal)
                .padding(.vertical, 30)
                Spacer()
                
            }
            
            
            .navigationBarTitle("New ToDo", displayMode: .inline)
            .navigationBarItems(trailing: Button(action:{
                self.presentationMode.wrappedValue.dismiss()
            }){
                Image(systemName: "xmark")
            })
            .alert(isPresented: $errorShowing) {
                Alert(title: Text(errorTitle), message: Text(errorMessage),dismissButton: .default(Text("OK")))
            }
        }
        .accentColor(themes[self.theme.themeSettings].themeColor)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AddToDoView_Previews: PreviewProvider {
    static var previews: some View {
        AddToDoView()
    }
}
