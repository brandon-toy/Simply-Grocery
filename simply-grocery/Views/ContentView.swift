import SwiftUI
import Firebase
//import GoogleSignIn

struct SignUpPage: View {
    @State var signInSuccess: Bool = false
    
    var body: some View {
        return Group {
            if signInSuccess {
                Login().navigationBarBackButtonHidden(true)
            } else {
                SignUp(signInSuccess: $signInSuccess).navigationBarBackButtonHidden(true)
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
          if error != "" {
            Text("Error: "+error)
          }
          Spacer().frame(width:10, height:10)
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
      
      // Create user
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
          self.signInSuccess = true
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
        SignUpPage()
             .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
             .previewDisplayName("iPhone SE")
        SignUpPage()
      }
    }
}
