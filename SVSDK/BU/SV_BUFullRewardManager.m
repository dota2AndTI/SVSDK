//
//  SV_FullRewardManager.m
//  AdsDemo
//
//  Created by  on 2021/9/17.
//

#import "SV_BUFullRewardManager.h"

@interface SV_BUFullRewardManager ()<BUNativeExpressFullscreenVideoAdDelegate>

@property (nonatomic,strong)BUNativeExpressFullscreenVideoAd *sv_ad;
@property (nonatomic,assign)BOOL isEarned;

@end

@implementation SV_BUFullRewardManager

-(void)sv_requestAdsWithSlotID:(NSString *)idStr currentVC:(UIViewController *)vc immediatelyShow:(BOOL)isImmediately {
    self.currentVC = vc;
    self.isPromptly = isImmediately;
    self.sv_ad = [[BUNativeExpressFullscreenVideoAd alloc] initWithSlotID:idStr];
    self.sv_ad.delegate = self;
    [self.sv_ad loadAdData];
}

-(void)sv_showAds {
    if (self.sv_adsLoaded && !self.isPromptly) {
        BOOL flag = [self.sv_ad showAdFromRootViewController:self.currentVC];
        if (!flag) {//展示失败
            if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsShowFailedWithManager:error:adsType:)]) {
                [self.delegate sv_adsShowFailedWithManager:self error:nil adsType:SVAdsTypeBU];
            }
        }
    }
}

-(BOOL)sv_earnRewardStatus {
    return self.isEarned;
}

#pragma mark - BUNativeExpressFullscreenVideoAdDelegate
//广告素材物料加载成功
-(void)nativeExpressFullscreenVideoAdDidLoad:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsLoadSuccessWithManager:adsType:)]) {
        [self.delegate sv_adsLoadSuccessWithManager:self adsType:SVAdsTypeBU];
    }
}
// 返回的错误码(error)表示广告加载失败的原因，
- (void)nativeExpressFullscreenVideoAd:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *_Nullable)error {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsLoadFailedWithManager:error:adsType:)]) {
        [self.delegate sv_adsLoadFailedWithManager:self error:error adsType:SVAdsTypeBU];
    }
}

//视频下载完成   在此回调方法中进行广告的展示，可保证播放流畅和展示流畅，用户体验更好。
-(void)nativeExpressFullscreenVideoAdDidDownLoadVideo:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsManager:videoDownloadWithType:)]) {
        [self.delegate sv_adsManager:self videoDownloadWithType:SVAdsTypeBU];
    }
    if ([self.sv_ad isEqual:fullscreenVideoAd]) {
        if (self.isPromptly) {
            [fullscreenVideoAd showAdFromRootViewController:self.currentVC];
        }
        self.sv_adsLoaded = YES;
    }
}

// 渲染失败，网络原因或者硬件原因导致渲染失败,可以更换手机或者网络环境测试。建议升级到穿山甲最新版本SDK
-(void)nativeExpressFullscreenVideoAdViewRenderFail:(BUNativeExpressFullscreenVideoAd *)rewardedVideoAd error:(NSError *)error {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsRenderFailedWithManager:error:adsType:)]) {
        [self.delegate sv_adsRenderFailedWithManager:self error:error adsType:SVAdsTypeBU];
    }
}

- (void)nativeExpressFullscreenVideoAdViewRenderSuccess:(BUNativeExpressFullscreenVideoAd *)rewardedVideoAd {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsRenderSuccessWithManager:adsType:)]) {
        [self.delegate sv_adsRenderSuccessWithManager:self adsType:SVAdsTypeBU];
    }
}

// 此回调可知模版全屏视频的广告类型
-(void)nativeExpressFullscreenVideoAdCallback:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd withType:(BUNativeExpressFullScreenAdType)nativeExpressVideoAdType {
    
}
// 点击回调
-(void)nativeExpressFullscreenVideoAdDidClick:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsDidClick:adsType:)]) {
        [self.delegate sv_adsDidClick:self adsType:SVAdsTypeBU];
    }
}
// 点击5s跳过会触发此回调，如果需要在用户点击跳过时做相关的逻辑处理，可在此回调中进行相关逻辑处理
-(void)nativeExpressFullscreenVideoAdDidClickSkip:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsManager:videoSkipWithType:)]) {
        [self.delegate sv_adsManager:self videoSkipWithType:SVAdsTypeBU];
    }
}
// 点击关闭按钮会触发此回调
-(void)nativeExpressFullscreenVideoAdDidClose:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsClosedWithManager:adsType:)]) {
        [self.delegate sv_adsClosedWithManager:self adsType:SVAdsTypeBU];
    }
}
// 广告播放完成会触发此回调
-(void)nativeExpressFullscreenVideoAdDidPlayFinish:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *)error {
    if (!error) {
        self.isEarned = YES;
    }
}

@end
