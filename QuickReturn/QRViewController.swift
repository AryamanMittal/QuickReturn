//
//  QRViewController.swift
//  QuickReturn
//
//  Created by aryaman mittal on 14/10/23.
//

import UIKit

class QRViewController: UIViewController {

    @IBOutlet weak var qrImageView: UIImageView!
    var baseStringcurrent:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        showQR()
        self.navigationItem.title = "Return"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func showQR(){
        
        let baseString = String(baseStringcurrent.dropFirst(22))
        var imageQR:UIImage?
        if let imageData = Data(base64Encoded: baseString) {
            // Create a UIImage from the imageData
            if let image = UIImage(data: imageData) {
                // Set the image to the imageView
                
                imageQR = image
                qrImageView.image = imageQR!
            } else {
                // Handle the case where the image data couldn't be converted to a UIImage
                print("Failed to convert data to UIImage")
            }
        } else {
            // Handle the case where the imageData is nil
            print("Failed to decode data from the data URL")
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
