//
//  VideoController.swift
//  StruggleSwift
//
//  Created by 黄刚 on 2017/8/28.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

import UIKit

import AVKit
import AVFoundation

//资源：http://www.cocoachina.com/cms/data/sitemap.html,   http://www.jianshu.com/p/d35980045c2b
class VideoController: UIViewController {

    var playViewController = AVPlayerViewController()
    var playerView = AVPlayer()
    
    let playerBtn = UIButton(type: .custom)
    let playerController = UIButton(type: .custom)
    let onelineVideo = UIButton(type: .custom)
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.groupTableViewBackground

        playerBtn.frame = CGRect(x: 20, y: 70, width: 200, height: 30)
        playerBtn.setTitle("playerVideo", for: .normal)
        playerBtn.addTarget(self, action: #selector(playerPlayVideo), for: .touchUpInside)
        
        
        playerController.frame = CGRect(x: 20, y: 120, width: 200, height: 30)
        playerController.setTitle("playerControllerVideo", for: .normal)
        playerController.addTarget(self, action: #selector(playerViewControllerPlayVideo), for: .touchUpInside)
        
        onelineVideo.frame = CGRect(x: 20, y: 160, width: 200, height: 30)
        onelineVideo.setTitle("onelineVideo", for: .normal)
        onelineVideo.addTarget(self, action: #selector(playOnlineVideo), for: .touchUpInside)

        
        self.view.addSubview(playerBtn)
        self.view.addSubview(playerController)
        self.view.addSubview(onelineVideo)
        
    }
    
    
//    MARK: - Player 播放视频
    func playerPlayVideo() {
        //        定义一个视频路径："/Users/huanggang/Desktop/资源/万由里.mp4"
        let filePath = "/Users/huanggang/Desktop/资源/万由里.mp4"
        let videoURL = URL(fileURLWithPath: filePath)
        //        定义一个视频播放器，通过本地文件路径初始化
        let player = AVPlayer(url: videoURL)
        //        设置大小和位置（全屏
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        //        添加到界面上
        self.view.layer.addSublayer(playerLayer)
        //        开始播放
        player.play()
        

    }
    
//    MARK - AVPlayerViewController
    func playerViewControllerPlayVideo() {
        //        定义一个视频路径："/Users/huanggang/Desktop/资源/万由里.mp4"
        let filePath = "/Users/huanggang/Desktop/资源/万由里.mp4"
        let videoURL = URL(fileURLWithPath: filePath)
        //        定义一个视频播放器，通过本地文件路径初始化
        let player = AVPlayer(url: videoURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) { 
            playerViewController.player?.play()
        }
        
    }
    
//    MARK - 播放在线视频
    func playOnlineVideo() {
        let filePath = "http://v1-tt.ixigua.com/55b964aa38c0008f77f4c037de778a8e/59a43863/video/m/220920fad442249428786043e2a098fa46311510c9300001a2fe6260dc3/"
        let videoURL =  URL(string: filePath)!
        let player = AVPlayer(url: videoURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
