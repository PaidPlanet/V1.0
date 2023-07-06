import SwiftUI
import AuthenticationServices
import Firebase

struct LoginPage: View {
   
    @State private var email = ""
    @State private var password = ""
    @State private var name = ""
    @State private var userIsLoggedIn = false
    @State private var shake = false
    @State private var confirmEmail = ""
    @State private var confirmPassword = ""

    
    @State private var isSignUpMode = false
    
    func loginUser() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
                shake = true
            } else {
                userIsLoggedIn = true
                shake = false
            }
        }
    }
    
    func registerUser() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                userIsLoggedIn = true
            }
        }
    }
    
    var body: some View {
        if userIsLoggedIn {
            HomeView()
        } else {
            unLogged
        }
    }
    
    var unLogged: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .opacity(0.5) // Adjust the opacity as needed for the green tint
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Spacer()
                HStack {
                    Text(("Welcome to"))
                        .font(.custom("Avenir", size: 32))
                        .fontWeight(.black)
                        .foregroundColor(Color(hex: "D9D9D9"))
                        .overlay(
                            Text(("Welcome to"))
                                .font(.custom("Avenir", size: 32))
                                .fontWeight(.black)
                                .foregroundColor(.black)
                                .offset(x: 1, y: 1)
                        )
                    Text(("PaidPlanet"))
                        .font(.custom("Avenir-Oblique", size: 32))
                        .fontWeight(.black)
                        .foregroundColor(Color(hex: "1B463C"))
                }
                .padding(.top, 250)
                
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .padding(.horizontal, 15)
                    .font(.footnote.weight(.bold))
                    .padding(.vertical, 10)
                    .background(Color(hex: "D9D9D9"))
                    .cornerRadius(14.0)
                    .padding(.horizontal, 25)
                    .font(.custom("Avenir", size: 20))
                /*
                    .opacity(isSignUpMode ? 1.0 : 0.0)
                    .padding(.bottom, isSignUpMode ? 20 : 0)
                    .disabled(!isSignUpMode)
                 */
                
                if isSignUpMode {
                    TextField("Confirm Email", text: $confirmEmail)
                        .autocapitalization(.none)
                        .padding(.horizontal, 15)
                        .font(.footnote.weight(.bold))
                        .padding(.vertical, 10)
                        .background(Color(hex: "D9D9D9"))
                        .cornerRadius(14.0)
                        .padding(.horizontal, 25)
                        .font(.custom("Avenir", size: 20))
                        .padding(.bottom, 20)
                }
                
                SecureField("Password", text: $password)
                    .autocapitalization(.none)
                    .padding(.horizontal, 15)
                    .font(.footnote.weight(.bold))
                    .padding(.vertical, 10)
                    .background(Color(hex: "D9D9D9"))
                    .cornerRadius(14.0)
                    .padding(.horizontal, 25)
                    .font(.custom("Avenir", size: 20))
                
                if isSignUpMode {
                    SecureField("Confirm Password", text: $confirmPassword)
                        .autocapitalization(.none)
                        .padding(.horizontal, 15)
                        .font(.footnote.weight(.bold))
                        .padding(.vertical, 10)
                        .background(Color(hex: "D9D9D9"))
                        .cornerRadius(14.0)
                        .padding(.horizontal, 25)
                        .font(.custom("Avenir", size: 20))
                        .padding(.bottom, 20)
                }
                
                if isSignUpMode {
                    TextField("What would you like to be called?", text: $name)
                        .autocapitalization(.none)
                        .padding(.horizontal, 15)
                        .font(.footnote.weight(.bold))
                        .padding(.vertical, 10)
                        .background(Color(hex: "D9D9D9"))
                        .cornerRadius(14.0)
                        .padding(.horizontal, 25)
                        .font(.custom("Avenir", size: 20))
                        .padding(.bottom, 20)
                }
                
                Button(action: {
                    if isSignUpMode {
                        // Check if email and confirmEmail match
                        if email == confirmEmail {
                            // Check if password and confirmPassword match
                            if password == confirmPassword {
                                // Register user
                                registerUser()
                            } else {
                                // Show password mismatch error
                                //come back to this later!
                                print("Your passwords do not match.")
                            }
                        } else {
                            // Show email mismatch error
                            
                            print("Your email do not match.")
                        }
                    } else {
                        // Login user
                        loginUser()
                    }
                }, label: {
                    Text(isSignUpMode ? "Sign Up" : "Login")
                        .font(.custom("Avenir", size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: "D9D9D9"))
                        .frame(width: 220, height: 60)
                        .background(Color(hex: "1B463C"))
                        .cornerRadius(14.0)
                        .padding(.bottom, 50)
                })
                
                Button(action: {
                    isSignUpMode.toggle()
                }, label: {
                    Text(isSignUpMode ? "Already have an account? Log in" : "New to PaidPlanet? Sign up here")
                        .font(.custom("Avenir", size: 20))
                        .fontWeight(.black)
                        .foregroundColor(Color(hex: "D9D9D9"))
                        .overlay(
                            Text(isSignUpMode ? "Already have an account? Log in" : "New to PaidPlanet? Sign up here")
                                .font(.custom("Avenir", size: 20))
                                .fontWeight(.black)
                                .foregroundColor(.black)
                                .offset(x: 1, y: 1)
                        )
                        .font(.custom("Avenir", size: 20))
                        .font(.footnote.weight(.bold))
                        .foregroundColor(Color(hex: "D9D9D9"))
                        .cornerRadius(14.0)
                        .padding(.bottom, 50)
                })
                Spacer()
            }
            .padding()
        }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}

// Convert hex to color
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}


class EmailManager {
    static let shared = EmailManager()
    var email: String = ""
    
    private init() {}
}
