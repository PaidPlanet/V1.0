import Foundation
import SwiftUI
import Firebase


//todo: make the settings button functional with a logout button

import Foundation
import CITTopTabBar
import SwiftUI
struct HomeView: View {
    @State var selectedTab: Int = 0
    @State var tabs: [CITTopTab] = [
        .init(
            title: "Home" ,
            icon: .init(systemName: "house.fill"),
            iconColorOverride: .white,
            selectedIconColorOverride: .green
        ),
        .init(
            title: "Scan" ,
            icon: .init(systemName: "camera.viewfinder"),
            iconColorOverride: .white,
            selectedIconColorOverride: .green
        ),
        .init(
            title: "Transactions",
            icon: .init(systemName: "archivebox.fill"),
            iconColorOverride: .white,
            selectedIconColorOverride: .green
        ),
        .init(
            title: "Profile",
            icon: .init(systemName: "person.crop.square.fill"),
            iconColorOverride: .white,
            selectedIconColorOverride: .green
        )
    ]

    var config: CITTopTabBarView.Configuration {
        var example: CITTopTabBarView.Configuration = .exampleUnderlined
        example.textColor = .white
        example.backgroundColor = .black
        example.font = Font.custom("Avenir", size: 16).bold() // Set the desired font here
        example.iconSize = CGSize(width: 30, height: 30) // Set the desired icon size here
        return example
    }


    var body: some View {
        VStack {
            CITTopTabBarView(selectedTab: $selectedTab, tabs: $tabs, config: config)

            TabView(selection: $selectedTab) {
                            HomeTab()
                                .tag(0)

                            AddView()
                                .tag(1)

                            TransactionsView()
                                .tag(2)

                            ProfileView()
                                .tag(3)
                        }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .edgesIgnoringSafeArea(.all)
        }
        .background(Color.green)
        .preferredColorScheme(.dark)
        .edgesIgnoringSafeArea(.all)
    }
}

struct TransactionsView: View {
    var body: some View {
        Text("Transactions View")
    }
}

struct HomeTab: View {
    var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        if (6..<12).contains(hour) {
            return "Good Morning"
        } else if (12..<18).contains(hour) {
            return "Good Afternoon"
        } else {
            return "Good Evening"
        }
    }
    
    var body: some View {
        ZStack {
            Color(hex: "C9EAD4")
                .ignoresSafeArea()
            
            VStack {
                ZStack {
                    Color(hex: "C9EAD4")
                    VStack {
                        HStack {
                            Text("PaidPlanet")
                                .font(.custom("Avenir", size: 38))
                                .fontWeight(.black)
                                .kerning(0.5)
                                .foregroundColor(Color(hex: "1B463C"))
                                .padding(.leading, 12)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                            Button(action: {
                               ProfileView()
                            }) {
                                Image(systemName: "person.circle")
                                    .font(.title)
                                    .padding(.trailing, 15)
                                    .foregroundColor(Color(hex: "1B463C"))
                            }
                        }
                        
                        Text(greeting)
                            .font(.custom("Avenir", size: 25))
                            .font(.title)
                            .foregroundColor(Color(hex: "1B463C"))
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 15)
                        
                        Text(Date(), style: .date)
                            .font(.custom("Avenir", size: 20))
                            .font(.title)
                            .foregroundColor(Color(hex: "1B463C"))
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 15)
                        
                        
                        //recent transaction view
                        Rectangle()
                            .fill(Color(hex: "1B463C"))
                            .frame( height: 265)
                            .cornerRadius(14.0)
                            .padding(.horizontal)
                            .overlay(
                                VStack() {
                                    
                                        Text("Recent Transactions")
                                            .font(.custom("Avenir", size: 35))
                                            .font(.title)
                                            .fontWeight(.black)
                                            .foregroundColor(.white)
                                            .frame(minWidth: 0, maxWidth: .infinity)
                                    
                                    
                                    Rectangle()
                                        .fill(Color.white)
                                        .frame(height: 2)
                                        .padding(.horizontal, 35)
                                        .padding(.top, -25)
                                
                                    
                                    VStack(alignment: .leading, spacing: 10) {
                                        //change these later to recent transaction view
                                        TransactionBox(date: "5/27/23", status: "Completed", amount: "approx. $50.23")
                                        TransactionBox(date: "5/20/23", status: "Completed", amount: "approx. $35.23")
                                        TransactionBox(date: "5/26/23", status: "Pending", amount: "approx. $30.34")
                                    }
                                    .padding(.horizontal, 35)
                                    .padding(.top, -20)
                                    
                                    
                                    RoundedRectangle(cornerRadius: 14)
                                            .fill(Color.white)
                                            .frame(height: 35)
                                            .overlay(
                                                    VStack(alignment: .leading) {
                                                        Text("View All Transactions")
                                                    .font(.custom("Avenir", size: 23))
                                                    .fontWeight(.bold)
                                                    .foregroundColor(Color(hex: "1B463C"))
                                                    .padding(.top, 11)
                                                    .padding(.leading, 25)
                                                                                   
                                                    Spacer()
                                                        }
                                                        )
                                            .padding(.horizontal, 35)
                                                            
                                }
                            )
                        
                        Spacer()
                            .frame(height: 15)
                        
                       
                        Rectangle()
                            .fill(Color(hex: "67C587"))
                            .frame(height: 85)
                            .cornerRadius(14.0)
                            .padding(.horizontal, 15)
                            .overlay(
                                VStack(alignment: .center) { // Updated alignment to center
                                    Button(action: {
                                        // Handle button tap
                                    }) {
                                        Text("Need Help with PaidPlanet?")
                                            .font(.custom("Avenir", size: 25))
                                            .fontWeight(.black)
                                            .foregroundColor(Color(hex: "1B463C"))
                                    }
                                    
                                    Button(action: {
                                        // Handle button tap
                                    }) {
                                        Text("Learn more here.")
                                            .font(.custom("Avenir", size: 20))
                                            .foregroundColor(Color(hex: "1B463C"))
                                            .padding(.leading, 5)
                                    }
                                }
                            )

                        

                        Spacer().frame(height: 15)
                        
                        
                        Rectangle()
                            .fill(Color(hex: "67C587"))
                            .frame(height: 85)
                            .cornerRadius(14.0)
                            .padding(.horizontal, 15)
                            .overlay(
                                VStack(alignment: .leading) {
                                    Button(action: {
                                        // Handle button tap
                                    }) {
                                        Text("View your sustainability score")
                                            .font(.custom("Avenir", size: 25))
                                            .fontWeight(.black)
                                            .foregroundColor(Color(hex: "1B463C"))
                                    }
                                    
                                    Button(action: {
                                        // Handle button tap
                                    }) {
                                        Text("Learn more here.")
                                            .font(.custom("Avenir", size: 20))
                                            .foregroundColor(Color(hex: "1B463C"))
                                            .padding(.leading, 5)
                                    }
                                }
                            )
                        

                        Spacer(minLength: 0)
                        
                        
                    }
                }
                
                // todo fix divider later
                //make it so that the taskbar at the bottom has the add tab standout
                Color.white
                    .frame(height: 1)
            }
        }
    }
}

struct TransactionBox: View {
    var date: String
    var status: String
    var amount: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(date)
                    .font(.custom("Avenir", size: 16))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                
                Spacer()
                
                Text(status)
                    .font(.custom("Avenir", size: 16))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                
                Spacer()
                
                Text(amount)
                    .font(.custom("Avenir", size: 16))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }
            
            Rectangle()
                .fill(Color.white)
                .frame(height: 1)
        }
    }
}

struct AddView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Add Tab")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
        }
        .background(Color.white) // Add a background color to make the tab visible
    }
}


struct ProfileView: View {
    var body: some View {
        Text("Profile Tab")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct CenterTabButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 30))
                .foregroundColor(.white)
            
            Text("Add")
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hex: "1B463C"))
                .frame(height: 60)
                .padding(.horizontal)
        )
        .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
        .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}
