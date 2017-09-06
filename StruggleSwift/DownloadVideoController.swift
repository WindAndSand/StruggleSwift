//
//  DownloadVideoController.swift
//  StruggleSwift
//
//  Created by HuangGang on 2017/9/4.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

import UIKit
import Alamofire
import AVKit
import AVFoundation

//视频下载：http://blog.csdn.net/u012297622/article/details/62089220 ，http://www.cocoachina.com/ios/20141203/10514.html
//Download类：http://www.jianshu.com/p/09227d2e51ca
//下载图片：http://www.jianshu.com/p/f1208b5e42d9

class DownloadVideoController: UIViewController {
    let progress: UIProgressView! = UIProgressView(frame: CGRect.zero)
    var cancelledData: Data?    //停止下载时保存已下载部分
    var downloadRequest: DownloadRequest!
    
    
    
    var videoUrl:String = "http://112.65.235.161/vlive.qqvideo.tc.qq.com/s00223no2is.p201.1.mp4?sdtfrom=v1010&guid=c04547d98851d0968ca0c30bb3fe7c43&vkey=5B46FD2FBB9EED8072F5DB7CAFCD6F10744594516C28415A5BAE9A23A1F0F68576ED30A586465A952ADA5858968CC1B26DAE90D79C3DA65B03C63BB0D37F33DAB5E215D029A51E1582CF198391511564997A3E627E0D128ECFD1D9E93CD5B02676B20B3DA974D09062D84264151DC55E&locid=1d20eacc-9dce-4014-93e4-49e2b1f96266&size=20133046&ocid=1412898732"
    var videoUrl2:String = "http://112.65.235.161/vlive.qqvideo.tc.qq.com/p0022r6bpey.p201.1.mp4?sdtfrom=v1010&guid=c04547d98851d0968ca0c30bb3fe7c43&vkey=6E67D5E280D3660CAD081D0CB6E9D2838273552E67407B6D552EEABBB2F33EBD83D18466960E770E67950A7C48BB0A5E8B5D91BB5F53C575771AC7FCCAF123DF7E0990914B3AFC428FD4A82E4FB857667753EC5C3B259B54B7D675D5C2628C886B0648D1D2D0E9924B864B8056755609&locid=a368a2bc-de9a-466d-a835-15cccd415310&size=20165368&ocid=1362567084"
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    指定下载路径
    let destination:DownloadRequest.DownloadFileDestination = {_, response in
    
        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentURL.appendingPathComponent(response.suggestedFilename!)
        return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        
        
    
    }
    
    func downloadProgress(progress: Progress)  {
        self.progress.setProgress(Float(progress.fractionCompleted), animated: true)
        print("当前进度:\(progress.fractionCompleted*100)%")
    }
    
    /*
    func downloadReponse(response: DownloadResponse<Data>) {
        switch response.result {
        case .success( _):
//            下载完成
            DispatchQueue.main.async{
                print("路径:\(String(describing: response.destinationURL?.path))")
                let item = AVPlayerItem(url: URL(fileURLWithPath: (response.destinationURL?.path)!))
                let play = AVPlayer(playerItem: item)
                let playController = AVPlayerViewController()
                playController.player = play
                self.present(playController, animated: true, completion: { 
                    
                })
            }
        case .failure(error:):
            self.cancelledData = response.resumeData  //意外中止的话把已下载的数据存起来
            break
        }
    }
 */
    
}
