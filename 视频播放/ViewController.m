//
//  ViewController.m
//  视频播放
//
//  Created by 王奥东 on 16/7/16.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "ViewController.h"

#import <AVFoundation/AVFoundation.h>


@interface ViewController ()
{
    AVPlayer *player;
    Float64 cur;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //创建要播放的元素
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"Alizee_La_Isla_Bonita副本.mp4" withExtension:nil];
    //playerItemWithAsset：通过设备相册里面的内容创建一个要播放的对象
    //这里直接选择使用URL读取
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    
    //duration 当前播放元素的总时长
    //    item.duration
    
    //status加载的状态:
    //UnKnow 未知，ReadyToPlay 准备播放，Failed 播放失败
    //    item.status
    
    
    //时间控制的类目
    //    item.current...
    //    item.forwardPlaybackEndTime 跳到结束位置
    //    item.reversePlaybackEndTime 跳到开始位置
    
    
    //创建播放器
    player = [AVPlayer playerWithPlayerItem:item];
    
    //也可以直接withURL获得一个地址的视频文件
    //    player.externalPlaybackVideoGravity 视频播放的样式
    
    //    普通样式
    //    player.externalPlaybackVideoGravity = AVLayerVideoGravityResizeAspect
    //    填充样式
    //    player.externalPlaybackVideoGravity = AVLayerVideoGravityResizeAspectFill
    //获得当前播放的视频元素
    //    player.currentItem
    
    
    //创建视频显示的图层
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
    layer.frame = CGRectMake(0, 0, 375, 667);
    
    //显示播放视频的视图层要添加到self.view的视图上面
    [self.view.layer addSublayer:layer];
    
    
    //通过监听status判断是否准备好
    [item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    //播放
    [player play];
    

    
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
  
    switch ([change[@"new"]integerValue]) {
        case 0:{
            NSLog(@"未知状态");
            break;
        }
        case 1:{
            //时长的值是CMTime类型
            //包含进度value 与帧率timescale
//            NSLog(@"视频的总时长:%f",CMTimeGetSeconds(player.currentItem.duration));
            
            cur = CMTimeGetSeconds(player.currentItem.duration);
        }
        case 2:{
            NSLog(@"加载失败");
            break;
        }
            
        default:
            break;
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //跳转到某一个进度
    [player seekToTime:CMTimeMake(cur, 1)];
    
}



















@end
