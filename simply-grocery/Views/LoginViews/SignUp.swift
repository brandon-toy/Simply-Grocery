import SwiftUI
import Firebase
//import GoogleSignIn

struct SignUpPage: View {
  @State var signInSuccess: Bool = false
  @State var user: userSettings = userSettings()
    
  var body: some View {
    return Group {
      if signInSuccess {
        GroceryListCheck()
          .navigationBarTitle("Simply Grocery")
          .navigationBarBackButtonHidden(true)
          .environmentObject(user)
      } else {
        SignUp(signInSuccess: $signInSuccess,user: $user)
          .navigationBarHidden(false)
        }
      }
  }
}

struct SignUp: View {
    
    @Binding var signInSuccess: Bool
    @Binding var user: userSettings
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var error: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
        Title()
         Spacer().frame(width:10, height:5)
          if error != "" {
            Text(error).font(.caption)
          }
          Spacer().frame(width:10, height:5)
            VStack(spacing: 1) {
                TextField("Name", text: $name)
                  .font(.caption)
                  .autocapitalization(.words)
                Divider()
            }
            
            VStack(spacing: 1) {
                TextField("Email", text: $email)
                  .font(.caption)
                  .autocapitalization(.none)
                Divider()
            }
            
            VStack(spacing: 1) {
                SecureField("Password", text: $password)
                  .font(.caption)
                Divider()
            }
            
            Button(action: signUp) {
                Text("Sign up")
            }
          
          Spacer().frame(width: 10, height: 250)
            
        }.padding(50)
         .navigationBarBackButtonHidden(false)
    }

  /**
   * Signup: Triggered when user clicks 'Sign Up'
   * Verifies user input and then calls authenticateAndDatabase
   */
  func signUp() {
    print("Signing the user in")
    if(!verifyEmail(user: self.email)) {
      self.error = "Not an email"
    } else if(self.password.count < 6) {
      self.error = "Password must be longer than 6 characters"
    } else if(self.name == "") {
      self.error = "Name must be filled"
    } else {
      authenticateAndDatebase() // Create user in firebase
    }
  }
  
  /**
   * Verifies if the user has a well formatted email
   */
  func verifyEmail(user: String) -> Bool {

      let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
      let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    
      return emailPred.evaluate(with: user)
  }
  
  /**
   * Authenticate and checks if the user is already in the database
   * TODO: Show message if user is already in the database
   */
  func authenticateAndDatebase() {
    Auth.auth().createUser(withEmail: self.email, password: self.password) { authResult, error in
      if error != nil {
        print("Error creating user")
        print(error!)
      } else {
        let offlineSync = database(user: self.user)
        offlineSync.offlineCacheInit()
        Firestore.firestore().enableNetwork { (error) in
          let db = Firestore.firestore()
          db.collection("users").document(self.email).setData([
            "name": self.name,
            "password": self.password,
            "uid": authResult!.user.uid,
            "groceryList": [String](),
            ]
          ) { (error) in
              if error != nil {
                self.error = "Error creating user in database"
              } else {
                self.signInSuccess = true
                self.user.setLogin(val: true)
                self.user.setUserDetails(name: self.name, email: self.email, login: true)
            }
          }
            // successfully created account
//            self.signInSuccess = true
//            userSettings().setLogin(val: true)
//            self.setUserSettings(name: self.name, email: self.email)
        }

      }
    }
  }
}

struct CheckSignUp_Previews: PreviewProvider {
    static var previews: some View {
      Group {
        SignUpPage()
           .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
           .previewDisplayName("iPhone 11 Pro")
        SignUpPage()
           .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
           .previewDisplayName("iPhone XS Max")
           .environment(\.colorScheme, .dark)
      }
    }
}
