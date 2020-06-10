//
//  KMCallingSystemController.swift
//  KMAgoraRtc
//
//  Created by Ed on 2020/3/17.
//

import UIKit
import Kingfisher
@objc public protocol KMCallingSystemOperationDelegate:NSObjectProtocol {
    /// 也可以通过通知来实现方法"answerCallingInKMCallingOperation"
    func answerCallingInKMCallingOperation()
    /// 也可以通过通知来实现方法"rejectedCallingInKMCallingOperation"
    func rejectedCallingInKMCallingOperation()
}


@objc(KMCallingSystemController)
public class KMCallingSystemController: UIViewController {

    @IBOutlet weak var doctorImage: UIImageView!
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var chatTypeLab: UILabel!
    @IBOutlet weak var hangUpBtn: UIButton!
    @IBOutlet weak var answerBtn: UIButton!
    @objc public var callName:String?
    @objc public var callImage:String?
    @objc public weak var delegate:KMCallingSystemOperationDelegate?
//    @objc public weak var userDelegate:KMCallInfoModel?
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: NSStringFromClass(KMCallingSystemController.self), bundle: KMAgoraRTCTools.getcurrentBundle())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        if let urlStr = callImage,
            let url = URL(string: urlStr) {
            doctorImage.kf.setImage(with: url)
        }
        doctorName.text = callName

        // Do any additional setup after loading the view.
    }
    @IBAction func clickeHangUpBtn(_ sender: Any) {
        delegate?.rejectedCallingInKMCallingOperation()
        NotificationCenter.default.post(name: Notification.Name("rejectedCallingInKMCallingOperation"), object: nil)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func clickeAnswerBtn(_ sender: Any) {
        delegate?.answerCallingInKMCallingOperation()
        NotificationCenter.default.post(name: Notification.Name("answerCallingInKMCallingOperation"), object: nil)
        dismiss(animated: true, completion: nil)
    }
    

}
