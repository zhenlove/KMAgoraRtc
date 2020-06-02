//
//  KMFloatViewManager.swift
//  KMAgoraRtc
//
//  Created by Ed on 2018/9/26.
//  Copyright © 2018 Ed. All rights reserved.
//


import Foundation
import UIKit
import AgoraRtcKit
extension NSObject {
    public func kmCurrentViewController() -> UIViewController? {
        var vc = UIApplication.shared.keyWindow?.rootViewController
        while let vc1 = vc {
            if let newVC = vc1 as? UITabBarController {
                vc = newVC.selectedViewController
            }
            if let newVC = vc1 as? UINavigationController {
                vc = newVC.visibleViewController
            }
            if vc1.presentationController != nil {
                vc = vc1
            } else {
                break
            }
        }
        return vc
    }
    
    public func kmCurrentNavigationController() -> UINavigationController? {
        return kmCurrentViewController()?.navigationController
    }
    
    public func kmCurrentTabBarController() -> UITabBarController? {
        return kmCurrentViewController()?.tabBarController
    }
}

@objc
public protocol KMFloatViewManagerDelegate : NSObjectProtocol {
    func clickedHangupButton()
    func clickedPrescribeButton()
}



@objc(KMFloatViewManager)
public class KMFloatViewManager: NSObject {
    @objc public static let sharedInstance = KMFloatViewManager()
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    let stateHeight = UIApplication.shared.statusBarFrame.size.height
    
    var agoraKit: AgoraRtcEngineKit?
    var agoraRtcView: KMAgoraRtcView?
    @objc public weak var delegate:KMFloatViewManagerDelegate?
    @objc public var isShow:Bool = false
    
    /// 初始化视图
    func initializeView(_ userType:Int) {
        agoraRtcView = KMAgoraRtcView(userType)
        agoraRtcView?.operateView.delegate = self
        agoraRtcView?.delegate = self
    }
    
    /// 初始化声网SDK
    // 93493485679640ec8f2a91035111ee01
    public func initializeAgotaEngine(_ appId: String) {
        agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId: appId, delegate: self)
    }
    
    /// 设置通信模式
    func setupVideo() {
        agoraKit?.enableVideo()
        agoraKit?.setVideoEncoderConfiguration(AgoraVideoEncoderConfiguration(size: AgoraVideoDimension640x360,
                                                                              frameRate: .fps15,
                                                                              bitrate: AgoraVideoBitrateStandard,
                                                                              orientationMode: .adaptative))
    }
    
    /// 设置本地视频
    func setupLocalVideo() {
        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = 0
        videoCanvas.view = agoraRtcView?.localVideoView
        videoCanvas.renderMode = .hidden
        agoraKit?.setupLocalVideo(videoCanvas)
    }
    
    /// 加入频道
    func joinChannel(_ channelKey: String, _ channelId: String,_ userId: UInt) {
        agoraKit?.joinChannel(byToken: channelKey,
                              channelId: channelId,
                              info: nil,
                              uid: userId,
                              joinSuccess: { (_, _, _) -> Void in
                                  UIApplication.shared.isIdleTimerDisabled = true
        })
    }
    
    /// 退出频道
    func leaveChannel() {
        agoraKit?.leaveChannel { _ in
            UIApplication.shared.isIdleTimerDisabled = false
        }
    }
    
    
    /// 加载视图
    /// - Parameters:
    ///   - userType: userType: 0,系统用户；1,患者；2,医生；4,药店工作站用户
    @objc
    public func showView(channelKey: String, channelId: String, userId: UInt, appId:String, userType:Int) {
        isShow = true
        initializeView(userType)
        initializeAgotaEngine(appId)
        setupVideo()
        setupLocalVideo()
        joinChannel(channelKey,channelId,userId)
        agoraKit?.muteLocalAudioStream(false)
        agoraKit?.setEnableSpeakerphone(true)
        if let view = agoraRtcView {
            UIApplication.shared.keyWindow?.addSubview(view)
            view.frame = CGRect(x: 0, y: -screenHeight, width: screenWidth, height: screenHeight)
            UIView.animate(withDuration: 0.25) {
                view.frame = CGRect(x: 0, y: -self.screenHeight, width: self.screenWidth, height: self.screenHeight)
                view.frame = CGRect(x: 0, y: 0, width: self.screenWidth, height: self.screenHeight)
            }
        }
    }
    
    /// 隐藏视图
    @objc
    public func dissView() {
        if isShow {
            isShow = false
            if let view = agoraRtcView {
                UIView.animate(withDuration: 0.25, animations: {
                    if view.zoomOut {
                        view.alpha = 1.0
                        view.alpha = 0.0
                    } else {
                        view.frame = CGRect(x: 0, y: 0, width: self.screenWidth, height: self.screenHeight)
                        view.frame = CGRect(x: 0, y: -self.screenHeight, width: self.screenWidth, height: self.screenHeight)
                    }
                }) { _ in
                    view.removeFromSuperview()
                    self.leaveChannel()
                    AgoraRtcEngineKit.destroy()
                    self.agoraKit = nil
                    self.agoraRtcView = nil
                    self.agoraRtcView?.zoomOut = false
                }
            }
        }
    }
    
    /// 缩小视图
    func zoomOutView() {
        if let view = agoraRtcView {
            UIView.animate(withDuration: 0.25, animations: {
                let transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
                view.transform = transform
                view.center = CGPoint(x: self.screenWidth - view.frame.size.width / 2 - margin, y: view.frame.size.height / 2 + self.stateHeight)
                
            }) { _ in
                
                /// 切换为大图显示远程视频
                if !view.isExchange {
                    view.ViewTapped()
                }
                
                UIView.animate(withDuration: 0.25, animations: {
                    view.operateView.alpha = 1.0
                    view.operateView.alpha = 0.0
                    view.remoteVideo.alpha = 1.0
                    view.remoteVideo.alpha = 0.0
                })
            }
        }
    }
    
    /// 放大视图
    func enlargeView() {
        if let view = agoraRtcView {
            UIView.animate(withDuration: 0.25, animations: {
                let transform = CGAffineTransform(scaleX: 1, y: 1)
                view.transform = transform
                view.center = UIApplication.shared.keyWindow?.center ?? CGPoint(x: self.screenWidth / 2, y: self.screenHeight / 2)
            }) { _ in
                UIView.animate(withDuration: 0.25, animations: {
                    view.operateView.alpha = 0.0
                    view.operateView.alpha = 1.0
                    view.remoteVideo.alpha = 0.0
                    view.remoteVideo.alpha = 1.0
                })
            }
        }
    }
}

extension KMFloatViewManager: AgoraRtcEngineDelegate {
    /// 远端首帧视频接收解码回调
    public func rtcEngine(_ engine: AgoraRtcEngineKit, firstRemoteVideoDecodedOfUid uid: UInt, size: CGSize, elapsed: Int) {
        print("\(size.debugDescription)")
        agoraRtcView?.ViewTapped()
    }
    
    /// 用户加入回调
    public func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinedOfUid uid: UInt, elapsed: Int) {
        agoraRtcView?.remoteVideoView.isHidden = false
        
        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = uid
        videoCanvas.view = agoraRtcView?.remoteVideoView
        videoCanvas.renderMode = .fit
        agoraKit?.setupRemoteVideo(videoCanvas)
    }
    
    /// 用户离线回调
    public func rtcEngine(_ engine: AgoraRtcEngineKit, didOfflineOfUid uid: UInt, reason: AgoraUserOfflineReason) {
        agoraRtcView?.remoteVideoView.isHidden = true
        dissView()
    }
    
    /// 用户停止/重新发送视频回调
    public func rtcEngine(_ engine: AgoraRtcEngineKit, didVideoMuted muted: Bool, byUid: UInt) {
        agoraRtcView?.remoteVideoView.superview?.isHidden = muted
    }
    
    /// 语音质量回调
    public func rtcEngine(_ engine: AgoraRtcEngineKit, audioQualityOfUid uid: UInt, quality: AgoraNetworkQuality, delay: UInt, lost: UInt) {
        if quality.rawValue > 0 && quality.rawValue < 6 {
            let image = KMAgoraRTCTools.getImage(named: "icon_network-" + "\(6-quality.rawValue)")
            agoraRtcView?.operateView.signalBtn.setImage(image, for: .normal)
        }
    }
}

extension KMFloatViewManager: KMMediaOperationDelegate {
    func clickeMicroButton(_ sender: UIButton) {
        agoraKit?.muteLocalAudioStream(sender.isSelected)
    }
    
    func clickedCameraButton(_ sender: UIButton) {
        agoraKit?.muteLocalVideoStream(sender.isSelected)
        agoraRtcView?.localVideoView.superview?.isHidden = sender.isSelected
    }
    
    func clickedLoudspeakerButton(_ sender: UIButton) {
        agoraKit?.setEnableSpeakerphone(sender.isSelected)
    }
    
    func clickedZoomOutButton(_ sender: UIButton) {
        agoraRtcView?.zoomOut = true
        zoomOutView()
    }
    
    func clickedHangupButton(_ sender: UIButton) {
        delegate?.clickedHangupButton()
    }
    
    func clickedSwithCameraButton(_ sender: UIButton) {
        agoraKit?.switchCamera()
    }
    func clickedPrescribeButton(_ sender: UIButton) {
        // 开处方
        delegate?.clickedPrescribeButton()
    }
}

extension KMFloatViewManager: KMFloatViewDelegate {
    func clickeTappedFloatView() {
        if agoraRtcView?.zoomOut == true {
            agoraRtcView?.zoomOut = false
            enlargeView()
        }
        
    }
}
