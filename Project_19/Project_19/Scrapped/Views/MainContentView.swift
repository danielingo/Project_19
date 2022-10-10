import SwiftUI

struct MainContentView: View {
    @State private var showNewReminderView = false
    @State private var layoutStyle: GridLayoutStyle = .vertical
    @EnvironmentObject var viewModel: RemindersViewModel

    var body: some View {
        NavigationView {
            ReminderView(style: layoutStyle)
                .navigationTitle("Project 19")
                .navigationBarItems(
                    leading:
                        AYImageButton(systemName: "menu", label: "More items", action: {
                            // open more menu items here
                        }),
                    trailing: 
                        AYImageButton(systemName: "plus", label: "Add set", action: {
                            // pop-up to get create new item
                            showNewReminderView.toggle()
                        })



                        
                )
                .sheet(isPresented: $showNewReminderView) {
                    NewReminderView().environmentObject(viewModel)
                }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}