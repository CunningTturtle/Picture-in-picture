//
//  BackPlayerTools.swift
//  P-P
//
//  Created by 小小李子 on 2020/10/9.
//

import UIKit
import AVKit
protocol BackPlayerToolsDelegate: NSObjectProtocol{
    ///已经开始画中画
    func didStar()
    ///将要开启画中画
    func willStar()
    ///将要关闭画中画
    func willEnd()
    ///已经关闭画中画
    func didEnd()

}
extension BackPlayerToolsDelegate {
    func didStar(){}
    func willStar(){}
    func willEnd(){}
    func didEnd(){}
}



/// 画中画工具
/// 1 必须为全局变量
/// 2 建议提前给layer 同时给并且调用的话 需要加点延迟

class BackPlayerTools: NSObject, AVPictureInPictureControllerDelegate {

    
    
    var pipVC:AVPictureInPictureController!
    weak var delegate:BackPlayerToolsDelegate?
    override init() {
        super.init()
        
        self.setSession()
        print("是否支持 \(self.isCanBackPlayer())")
    }
    
    /// 是否支持
    /// - Returns: description
    func isCanBackPlayer() -> Bool {
        return AVPictureInPictureController.isPictureInPictureSupported();
    }
    
    /// 设置session
    func setSession() {
        try! AVAudioSession.sharedInstance().setCategory(.playback)
        try! AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
    }
    
    
    /// 开始播放
    func startPip() {
        pipVC.startPictureInPicture()
        NSLog("开始播放画中画")
    }
    ///结束播放
    func endPip() {
        pipVC.stopPictureInPicture()
    }
    
    func beginPip(_ layer:AVPlayerLayer) {
        pipVC = AVPictureInPictureController.init(playerLayer: layer)!
        pipVC.delegate = self
    }
    
    
    
    /**
     即将开启画中画
     @method        pictureInPictureControllerWillStartPictureInPicture:
     @param        pictureInPictureController
     The Picture in Picture controller.
     @abstract    Delegate can implement this method to be notified when Picture in Picture will start.
     */
    func pictureInPictureControllerWillStartPictureInPicture(_ pictureInPictureController: AVPictureInPictureController){
        if ((delegate?.responds(to: Selector.init(("willStar")))) != nil) {
            delegate?.willStar()
        }
    }
    
    
    /**
     已经开启画中画
     @method        pictureInPictureControllerDidStartPictureInPicture:
     @param        pictureInPictureController
     The Picture in Picture controller.
     @abstract    Delegate can implement this method to be notified when Picture in Picture did start.
     */
    func pictureInPictureControllerDidStartPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        if ((delegate?.responds(to: Selector.init(("didStar")))) != nil) {
            delegate?.didStar()
        }
        
    }
    
    
    /**
     开启画中画失败
     @method        pictureInPictureController:failedToStartPictureInPictureWithError:
     @param        pictureInPictureController
     The Picture in Picture controller.
     @param        error
     An error describing why it failed.
     @abstract    Delegate can implement this method to be notified when Picture in Picture failed to start.
     */
    func pictureInPictureController(_ pictureInPictureController: AVPictureInPictureController, failedToStartPictureInPictureWithError error: Error) {
        NSLog("开启失败");
    }
    
    
    /**
     即将关闭画中画
     @method        pictureInPictureControllerWillStopPictureInPicture:
     @param        pictureInPictureController
     The Picture in Picture controller.
     @abstract    Delegate can implement this method to be notified when Picture in Picture will stop.
     */
    func pictureInPictureControllerWillStopPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        if ((delegate?.responds(to: Selector.init(("willEnd")))) != nil) {
            delegate?.willEnd()
        }
    }
    
    
    /**
     已经关闭画中画
     @method        pictureInPictureControllerDidStopPictureInPicture:
     @param        pictureInPictureController
     The Picture in Picture controller.
     @abstract    Delegate can implement this method to be notified when Picture in Picture did stop.
     */
    func pictureInPictureControllerDidStopPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        if ((delegate?.responds(to: Selector.init(("didEnd")))) != nil) {
            delegate?.didEnd()
        }
    }
    
    
    /**
     关闭画中画且恢复播放界面
     @method        pictureInPictureController:restoreUserInterfaceForPictureInPictureStopWithCompletionHandler:
     @param        pictureInPictureController
     The Picture in Picture controller.
     @param        completionHandler
     The completion handler the delegate needs to call after restore.
     @abstract    Delegate can implement this method to restore the user interface before Picture in Picture stops.
     */
    func pictureInPictureController(_ pictureInPictureController: AVPictureInPictureController, restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler: @escaping (Bool) -> Void) {
        completionHandler(true)
    }
}


