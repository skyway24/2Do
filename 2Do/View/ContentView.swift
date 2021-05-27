//
//  ContentView.swift
//  2Do
//
//  Created by Akash Verma on 23/05/21.
//

import SwiftUI

struct ContentView: View {
    
    
    @Environment(\.managedObjectContext) var  managedObjectContext
    
    @State private var showAddToDoView: Bool = false
    @State private var animatingButton: Bool = false
    //@FetchRequest(entity: ToDo.entity(),sortDescriptors:[NSSortDescriptor(keyPath: \ToDo.name, ascending: true)])

    @FetchRequest(entity: ToDo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ToDo.name, ascending: true)]) var todos: FetchedResults<ToDo>
    
    
    var body: some View {
        
        NavigationView{
            ZStack {
                List{
                    ForEach(self.todos, id: \.self){ todo in
                        HStack{
                            Text(todo.name ?? "Unknown")
                            Spacer()
                            Text(todo.priority ?? "Unknown ")
                        }
                    }
                    .onDelete(perform: deleteToDo)
                }
               
                .navigationBarTitle("ToDo", displayMode: .inline)
                .navigationBarItems(leading: EditButton(),
                    trailing:
                                        Button(action:{
                                            self.showAddToDoView.toggle()
                                        }){
                                            Image(systemName: "plus")
                                        }
                    .sheet(isPresented: $showAddToDoView){
                        AddToDoView().environment(\.managedObjectContext, self.managedObjectContext)
                    }
            )
                if todos.count == 0{
                  EmptyListView()
                }
            } .sheet(isPresented: $showAddToDoView){
                AddToDoView().environment(\.managedObjectContext, self.managedObjectContext)
            }
            .overlay(
                ZStack {
                    
                    Group{
                        Circle().fill(Color.blue).opacity(self.animatingButton ? 0.2 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 68, height: 68, alignment: .center)
                        
                        Circle().fill(Color.blue).opacity(self.animatingButton ? 0.15 : 0).scaleEffect(self.animatingButton ? 1 : 0).frame(width: 88, height: 88, alignment: .center)
                        
                    }.animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true))
                    
                    Button(action: {
                        self.showAddToDoView.toggle()
                    }){
                        Image(systemName: "plus.circle.fill").resizable().scaledToFit().background(Circle().fill(Color("ColorBase"))).frame(width: 48, height: 48, alignment: .center)
                    }
                    .onAppear(perform: {
                        self.animatingButton.toggle()
                    })
                    
                   
                    
                }.padding(.bottom, 15)
                .padding(.trailing, 15)
                , alignment: .bottomTrailing
            )
        }
       
            
    }
    
    private func deleteToDo(at offsets: IndexSet){
        for index in offsets{
            let todo = todos[index]
            managedObjectContext.delete(todo)
            
            do{
                try managedObjectContext.save()
            
            }
            catch{
                print(error)
            }
        }
    
    }
}




struct ContentView_Previews: PreviewProvider {
    
     
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return ContentView()
            .environment(\.managedObjectContext, context)
    }
}
