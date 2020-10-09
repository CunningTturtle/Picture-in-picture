//
//  ViewController.swift
//  P-P
//
//  Created by 小小李子 on 2020/10/9.
//

import UIKit
import AVKit

class ViewController: UIViewController, BackPlayerToolsDelegate {
    
    
    let player = AVPlayer.init(playerItem: AVPlayerItem.init(url: URL.init(string: "http://tb-video.bdstatic.com/tieba-video/15_dc76d5a63817ebc2f08e5f323d67b753.mp4")!))
    let playerLayer = AVPlayerLayer()
    var manager:BackPlayerTools = BackPlayerTools.init()
 



    override func viewDidLoad() {
        super.viewDidLoad()

        self.addPlayer();
        self.addButton();
        
        manager.beginPip(playerLayer)
        manager.delegate = self
        // Do any additional setup after loading the view.
    }

    func addPlayer() {

        playerLayer.frame = CGRect.init(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width * 960/540.0)
        playerLayer.backgroundColor = UIColor.darkGray.cgColor
        playerLayer.player = player
        view.layer.addSublayer(playerLayer)
        player.play()
    }

    func addButton() {
        let control = UIButton.init(frame: CGRect.init(x: 0, y: playerLayer.frame.origin.y + playerLayer.frame.size.height + 20, width: view.frame.size.width, height: 44));
        control.setTitle("开始", for: .normal)
        control.backgroundColor = UIColor.black
        view.addSubview(control)

        control.addTarget(self, action: #selector(conClick), for: .touchUpInside)
    }


    @objc func conClick (){
        manager.startPip()
    }
    
}

