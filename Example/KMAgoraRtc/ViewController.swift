//
//  ViewController.swift
//  KMAgoraRtc
//
//  Created by zhenlove on 10/23/2019.
//  Copyright (c) 2019 zhenlove. All rights reserved.
//

import UIKit
import KMAgoraRtc

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let vc = KMCallingSystemController()
//        vc.delegate = self
//        vc.modalPresentationStyle = .fullScreen//UIModalPresentationFullScreen
//        present(vc, animated: true, completion: nil)
        
        let vc = KMTestViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

}

//extension ViewController : KMCallingSystemOperationDelegate {
//    func answerCallingInKMCallingOperation() {
//        print("接听")
//    }
//
//    func rejectedCallingInKMCallingOperation() {
//        print("挂断")
//    }
//
//
//}
