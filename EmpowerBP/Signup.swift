import UIKit
import Parse
import Alamofire

class Signup: UIViewController,
UITextFieldDelegate
{

    /* Views */
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var firstnameText: UITextField!
    @IBOutlet weak var lastnameText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var passconfirmText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
   

override func viewDidLoad() {
        super.viewDidLoad()

}


// MARK: - TAP TO DISMISS KEYBOARD
@IBAction func tapToDismissKeyboard(_ sender: UITapGestureRecognizer) {
    usernameText.resignFirstResponder()
    passwordText.resignFirstResponder()
    emailText.resignFirstResponder()
}
 
    
    
// MARK: - SIGNUP BUTTON
@IBAction func signupButton(_ sender: AnyObject) {
    
    if firstnameText.text == ""||lastnameText.text == ""||usernameText.text == "" || passwordText.text == "" || emailText.text == "" {
        simpleAlert("You must fill all the fields to sign Up.")
        
    } else if passwordText.text != passconfirmText.text {
        simpleAlert("Your passwords must match.")
        
    } else {
        showHUD()
        createUserProfile()
        self.hideHUD()
    }
}
   
// CREATE USER PROFILE
    
    func createUserProfile() {
        
        
        
        let headers = [
            "Authorization": "Bearer $TK"
        ]
        let parameters: Parameters = [
            "login": usernameText.text!,
            "firstName": firstnameText.text!,
            "lastName": lastnameText.text!,
            "email": emailText.text!,
            "password": passwordText.text!,
            "phone": "9029690635"
            
        ]
        Alamofire.request("https://aabusharekh-4.cs.dal.ca:8443/api/v1/register", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                    case .success:
                        print(response)
                        self.hideHUD()
                        self.performSegue(withIdentifier: "toMainScene", sender: self)
                        return
                    case .failure(let error):
                        print(response)
                        self.simpleAlert("\(error.localizedDescription)")
                        self.hideHUD()
                        return
                    }}

        }
    
    
// MARK: - TEXTFIELD DELEGATES
func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == firstnameText {   lastnameText.becomeFirstResponder()  }
    if textField == lastnameText {   usernameText.becomeFirstResponder()  }
    if textField == usernameText {   passwordText.becomeFirstResponder()  }
    if textField == passwordText {   passconfirmText.becomeFirstResponder()  }
    if textField == passconfirmText {  emailText.becomeFirstResponder()  }
    if textField == emailText {   emailText.resignFirstResponder()   }
        
return true
}
    
    

    
    
override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
}
}
