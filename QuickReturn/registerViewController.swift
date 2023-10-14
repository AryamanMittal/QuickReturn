//
//  registerViewController.swift
//  QuickReturn
//
//  Created by aryaman mittal on 12/10/23.
//

import UIKit
import Alamofire
class registerViewController: UIViewController {

    @IBOutlet weak var fNameField: UITextField!
    
    @IBOutlet weak var lNameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var otpTextField: UITextField!
    @IBOutlet weak var confPassField: UITextField!
    var regDic:[String:Any] = [:]
    var emailToFix:String = "" 

    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.text! = emailToFix

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerAction(_ sender: Any) {
        
        if let email = emailField.text, let password = passwordField.text,let cpass=confPassField.text{
                    if !email.validateEmailId(){
                        openAlert(title: "Alert", message: "Email address not found.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                            print("Okay clicked!")
                        }])
                    }else if !password.validatePassword(){
                        openAlert(title: "Alert", message: "Please enter valid password", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                            print("Okay clicked!")
                        }])
                    }else if cpass != password  {
                        openAlert(title: "Alert", message: "Passwords Do Not Match ", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                        print("Okay clicked!")
                    }])
                    }
                }else{
                    openAlert(title: "Alert", message: "Please add detail.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                        print("Okay clicked!")
                    }])
                }
        let regData = Registeration(email: emailField.text!, otp: otpTextField.text!, firstName: fNameField.text!, lastName: lNameField.text!, password: passwordField.text!)
        AF.request("https://arcanists-04-3jz1.onrender.com/api/v1/signup",method: HTTPMethod.post,parameters: regData,encoder: JSONParameterEncoder.default).response { responseObj in
            if(responseObj.data != nil){
                
                do{
                    self.regDic = try JSONSerialization.jsonObject(with: responseObj.data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! [String:Any]
                    print(self.regDic)
                    if(self.regDic["success"] as! Bool){
                        print("registered success")
                        DispatchQueue.main.async {
                           // let signInCon:logInViewController = self.storyboard?.instantiateViewController(identifier: "logIn_screen") as! logInViewController
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                    
                }
                catch{
                    print("json serializagtion error")
                }
            }
                
        }
        
        
        
    }
    
    
    
    
    

    

}
