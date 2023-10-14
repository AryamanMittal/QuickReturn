//
//  emailValidView.swift
//  QuickReturn
//
//  Created by aryaman mittal on 13/10/23.
//

import UIKit
import Alamofire
class emailValidView: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendOtpButton: UIButton!
    var otpDic:[String:Any] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendOtpAction(_ sender: Any) {
        if let email = emailTextField.text {
            let regMail = RegistMail(email: email)
            AF.request("https://arcanists-04-3jz1.onrender.com/api/v1/sendotp",method: HTTPMethod.post,parameters: regMail,encoder: JSONParameterEncoder.default).response { responseObj in
                if(responseObj.data != nil){
                    
                    do{
                        self.otpDic = try JSONSerialization.jsonObject(with: responseObj.data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! [String:Any]
                        print(self.otpDic)
                        if(self.otpDic["success"] as! Bool){
                            DispatchQueue.main.async {
                                let regCon:registerViewController = self.storyboard?.instantiateViewController(identifier: "register_screen") as! registerViewController
                                
                                  regCon.emailToFix = email
                                
                                    self.navigationController?.pushViewController(regCon, animated: true)
                                
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
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
