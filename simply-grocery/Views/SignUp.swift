import SwiftUI
import Firebase
//import GoogleSignIn

struct SignUpPage: View {
    @State var signInSuccess: Bool = false
    
    var body: some View {
        return Group {
            if signInSuccess {
                GroceryListCheck()
                  .navigationBarHidden(true)
                  .navigationBarTitle("Hidden Title")
            } else {
                SignUp(signInSuccess: $signInSuccess)
                  .navigationBarHidden(true)
                  .navigationBarTitle("Hidden Title")
            }
        }
    }
}

struct SignUp: View {
    
    @Binding var signInSuccess: Bool
    
    @State public var name: String = ""
    @State public var email: String = ""
    @State public var password: String = ""
    @State public var error: String = ""
    
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
                Divider()
            }
            
            VStack(spacing: 1) {
                TextField("Email", text: $email)
                Divider()
            }
            
            VStack(spacing: 1) {
                SecureField("Password", text: $password)
                Divider()
            }
            
            Button(action: signUp) {
                Text("Sign up")
            }
          Spacer().frame(width:10, height:250)
            
        }.padding(50)
         .navigationBarBackButtonHidden(true)
    }

    
  func signUp() {
      // TODO validate user
    print(userSettings().getLogin())
    if(!verifyEmail(user: self.email)) {
      self.error = "Not an email"
    } else if(self.password.count < 6) {
      self.error = "Password must be longer than 6 characters"
    } else {
      // Create user
      authenticateAndDatebase()
    }
  }
  
  func verifyEmail(user: String) -> Bool {

      let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
      let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    
      return emailPred.evaluate(with: user)
  }
  
  func authenticateAndDatebase() {
    Auth.auth().createUser(withEmail: self.email, password: self.password) { authResult, error in
      if error != nil {
        print("Error creating user")
      } else {
          let db = Firestore.firestore()
          db.collection("users").addDocument(data: ["name": self.name, "password": self.password, "uid": authResult!.user.uid]) { (error) in
              if error != nil {
                self.error = "Error creating user in database"
              }
          }
          // successfully created account
          print("fasdfasfsf")
          self.signInSuccess = true
          userSettings().setLogin(val: true)
      }
    }
  }
  
  func ShowError(_ message: String) {
    self.error = message
  }
}

struct CheckSignUp_Previews: PreviewProvider {
    static var previews: some View {
      Group {
        WelcomeView()
           .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
           .previewDisplayName("iPhone 11 Pro")
        WelcomeView()
           .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
           .previewDisplayName("iPhone XS Max")
           .environment(\.colorScheme, .dark)
      }
    }
}
