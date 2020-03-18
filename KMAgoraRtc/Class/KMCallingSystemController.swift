//
//  KMCallingSystemController.swift
//  KMAgoraRtc
//
//  Created by Ed on 2020/3/17.
//

import UIKit
import Kingfisher
@objc public protocol KMCallingSystemOperationDelegate:NSObjectProtocol {
    func answerCallingInKMCallingOperation()
    func rejectedCallingInKMCallingOperation()
}

@objc public protocol KMCallInfoModel:NSObjectProtocol {
    var callName:String? { get }
    var callImage:String? { get }
    
}

@objc(KMCallingSystemController)
public class KMCallingSystemController: UIViewController {

    @IBOutlet weak var doctorImage: UIImageView!
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var chatTypeLab: UILabel!
    @IBOutlet weak var hangUpBtn: UIButton!
    @IBOutlet weak var answerBtn: UIButton!
    
    @objc public weak var delegate:KMCallingSystemOperationDelegate?
    @objc public weak var userDelegate:KMCallInfoModel?
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: NSStringFromClass(KMCallingSystemController.self), bundle: KMAgoraRTCTools.getcurrentBundle())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        if let urlStr = userDelegate?.callImage,
            let url = URL(string: urlStr) {
            doctorImage.kf.setImage(with: url)
        }
        doctorName.text = userDelegate?.callName

        // Do any additional setup after loading the view.
    }
    @IBAction func clickeHangUpBtn(_ sender: Any) {
        delegate?.rejectedCallingInKMCallingOperation()
        dismiss(animated: true, completion: nil)
    }
    @IBAction func clickeAnswerBtn(_ sender: Any) {
        delegate?.answerCallingInKMCallingOperation()
        dismiss(animated: true, completion: nil)
    }
    

}
