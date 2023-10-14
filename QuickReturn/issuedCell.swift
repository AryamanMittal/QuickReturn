//
//  issuedCell.swift
//  QuickReturn
//
//  Created by aryaman mittal on 11/10/23.
//

import UIKit
import Alamofire
class issuedCell: UITableViewCell {
    
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var daysLeftLabel: UILabel!
    @IBOutlet weak var returnLabel: UILabel!
    @IBOutlet weak var IssueDateLabel: UILabel!
    var qrDic:[String:Any] = [:]
    var issueDic:[String:Any] = [:]

    var issCon : ViewController?
    var indexPth:IndexPath?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func returnAction(_ sender: Any) {
        print("return pressed")
        let bookid = issCon!.allbook[(indexPth!.row)].bookID
        print(bookid)
        //let bookid:String = currBook.id
            let bookData:IssBook = IssBook(bookId: bookid)
            AF.request("https://arcanists-04-3jz1.onrender.com/api/v1/generateQr",method: HTTPMethod.post,parameters: bookData,encoder: JSONParameterEncoder.default).response { respObj in
                if(respObj.data != nil){
                    
                    do{
                        self.qrDic = try JSONSerialization.jsonObject(with: respObj.data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! [String:Any]
                        print(self.qrDic)
                        if(self.qrDic.count == 2)
                        {
                            let qrString = self.qrDic["qrDataURL"] as! String
                            
                DispatchQueue.main.async
                {
                    let qrCon:QRViewController = self.issCon?.storyboard?.instantiateViewController(withIdentifier: "QRViewController") as! QRViewController
                    qrCon.baseStringcurrent = qrString
                    self.issCon?.navigationController?.pushViewController(qrCon, animated: true)
                    
                }
                        }
                        
                    }
                    catch{
                        print("json serializagtion error")
                    }
                }
            }
        
        
    }
    
    @IBAction func reissueAction(_ sender: Any) {
        let bookid = issCon!.allbook[(indexPth!.row)].bookID
        print(bookid)
        let bookData:IssBook = IssBook(bookId: bookid)

        AF.request("https://arcanists-04-3jz1.onrender.com/api/v1/reissue",method: HTTPMethod.put,parameters: bookData,encoder: JSONParameterEncoder.default).response { respObj in
            if(respObj.data != nil){
                
                do{
                    self.issueDic = try JSONSerialization.jsonObject(with: respObj.data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! [String:Any]
                    print(self.issueDic)
                    if(self.issueDic["success"] as! Bool){
                        DispatchQueue.main.async{
                            self.issCon?.openAlert(title: "Re-Issue Successful", message: "", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                                print("Okay clicked")
                            }])
                        }
                    }else{
                        DispatchQueue.main.async{
                            self.issCon?.openAlert(title: "Re-Issue Unsuccessful", message: "Cannot reissue book more than twice", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                                print("Okay clicked")
                            }])
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
