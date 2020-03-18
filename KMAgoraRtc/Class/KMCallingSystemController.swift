//
//  KMCallingSystemController.swift
//  KMAgoraRtc
//
//  Created by Ed on 2020/3/17.
//

import UIKit

@objc public protocol KMCallingSystemOperationDelegate:NSObjectProtocol {
    func answerCallingInKMCallingOperation()
    func rejectedCallingInKMCallingOperation()
}

@objc public protocol KMCallInfoModel:NSObjectProtocol {
    var callName:String? { get }
    var callImage:UIImage? { get }
    
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
        doctorImage.image = userDelegate?.callImage
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
