//
//  Menu.swift
//  Little Lemon
//
//  Created by CoraciasCaudata on 11/11/2024.
//

import SwiftUI
import CoreData

struct Menu: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @State var menuItems: [MenuItem] = []
    @State var searchText = ""
    @State var index = 3
    
    var body: some View {
        VStack(spacing: 0) {
            Header(isLoggedIn: true).frame(minHeight: 60)
            
            Hero()
                .zIndex(1)
                .frame(height: 200)
            VStack {
                TextField("🔎 Search menu", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal, 15)
                        .cornerRadius(10)
                        
                        .padding(.bottom, 10)
            }.background(Color.primary1)
            
            
            VStack(spacing: 5) {
                HStack {
                    Text("ORDER FOR DELIVERY!")
                        .font(.system(size: 20, weight: .bold, design: .none))
                        .foregroundColor(.highlight2)
                        .padding(EdgeInsets(top: 8, leading: 20, bottom: 0, trailing: 0))
                    Spacer()
                }
                
                HStack(spacing: 10) {
                    CategoryButton(title: "Starters", indexTrigger: 0, index: $index)
                    CategoryButton(title: "Mains", indexTrigger: 1, index: $index)
                    CategoryButton(title: "Desserts", indexTrigger: 2, index: $index)
                    CategoryButton(title: "All", indexTrigger: 3, index: $index)
                }.padding(.horizontal, 10)
            }
            .padding(.bottom, 8)
            .background(Color.secondary1)
            .zIndex(2)
            
            
            FetchedObjects(predicate: buildPredicate(),
                           sortDescriptors: buildSortDescriptors()) {
                (dishes: [Dish]) in
                List {
                    ForEach(dishes, id:\.self) { dish in
                        NavigationLink(destination: DetailItem(dish: dish)) {
                            DisplayDish(dish)
                        }
                    }
                }.padding(.top, -25)
            }
        }
        .background(Color(.highlight1))
        
        .task {
           await getMenuData(viewContext)
        }
    }
    
    
    private func buildPredicate() -> NSPredicate {
        switch index {
        case 0:
            return searchText == "" ?
            NSPredicate(format: "category MATCHES 'starters'") :
            NSPredicate(format: "(category MATCHES 'starters') && (title CONTAINS[cd] %@)", searchText)
        case 1:
            return searchText == "" ?
            NSPredicate(format: "category MATCHES 'mains'") :
            NSPredicate(format: "(category MATCHES 'mains') && (title CONTAINS[cd] %@)", searchText)
        case 2:
            return searchText == "" ?
            NSPredicate(format: "category MATCHES 'desserts'") :
            NSPredicate(format: "(category MATCHES 'desserts') && (title CONTAINS[cd] %@)", searchText)
        default:
            return searchText == "" ?
            NSPredicate(value: true) :
            NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
    
    private func buildSortDescriptors() -> [NSSortDescriptor] {
        [NSSortDescriptor(key: "title",
                          ascending: true,
                          selector:
                            #selector(NSString.localizedStandardCompare))]
    }
    
    func getMenuData(_ coreDataContext:NSManagedObjectContext) async {
        Dish.deleteAll(coreDataContext)
        
        let urlString: String = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: urlString)!
        let urlSession = URLSession.shared
        
        do {
            let (data, _) = try await urlSession.data(from: url)
            let fullMenu = try JSONDecoder().decode(MenuList.self, from: data)
            menuItems = fullMenu.menu
            
            // populate Core Data
            Dish.deleteAll(coreDataContext)
            viewContext.reset()     // THIS FIXES BUG
            Dish.createDishesFrom(menuItems:menuItems, coreDataContext)
        }
        catch { print(error) }
    }
}

#Preview {
    Menu().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}



