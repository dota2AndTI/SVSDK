//
//  SV_BURewardManager.m
//  AdsDemo
//
//  Created by  on 2021/9/17.
//

#import "SV_BURewardManager.h"

@interface SV_BURewardManager ()<BUNativeExpressRewardedVideoAdDelegate>

@property (nonatomic,strong)BUNativeExpressRewardedVideoAd *sv_ads;
@property (nonatomic,assign)BOOL isEarned;

@end

@implementation SV_BURewardManager

-(void)sv_buRequestRewardAdWith:(NSString *)idStr userId:(NSString *)userId viewController:(UIViewController *)vc promptlyShow:(BOOL)isImmediately {
    self.currentVC = vc;
    self.isPromptly = NO;
    self.isPromptly = isImmediately;
    
    BURewardedVideoModel *model = [[BURewardedVideoModel alloc] init];
    model.userId = userId;
    
    self.sv_ads = [[BUNativeExpressRewardedVideoAd alloc] initWithSlotID:idStr rewardedVideoModel:model];
    self.sv_ads.delegate = self;
    [self.sv_ads loadAdData];
}

-(void)sv_buShowRewardAdWith:(NSString *)adId {
    if (!self.isPromptly && self.sv_adsLoaded) {
        BOOL flag = [self.sv_ads showAdFromRootViewController:self.currentVC];
        if (!flag) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsShowFailedWithManager:error:adsType:)]) {
                [self.delegate sv_adsShowFailedWithManager:self error:nil adsType:SVAdsTypeBU];
            }
        }
    }
}

-(BOOL)sv_earnRewardStatus {
    return _isEarned;
}

#pragma mark - BUNativeExpressRewardedVideoAdDelegate
// 返回的错误码(error)表示广告加载失败的原因，
-(void)nativeExpressRewardedVideoAd:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsLoadFailedWithManager:error:adsType:)]) {
        [self.delegate sv_adsLoadFailedWithManager:self error:error adsType:SVAdsTypeBU];
    }
}

// 广告素材物料加载成功
-(void)nativeExpressRewardedVideoAdDidLoad:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsLoadSuccessWithManager:adsType:)]) {
        [self.delegate sv_adsLoadSuccessWithManager:self adsType:SVAdsTypeBU];
    }
    
    if ([rewardedVideoAd isEqual:self.sv_ads]) {
        if (self.isPromptly) {
            BOOL flag = [rewardedVideoAd showAdFromRootViewController:self.currentVC];
            if (!flag) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsShowFailedWithManager:error:adsType:)]) {
                    [self.delegate sv_adsShowFailedWithManager:self error:nil adsType:SVAdsTypeBU];
                }
            }
        }
        self.sv_adsLoaded = YES;
    }
}

//渲染失败，网络原因或者硬件原因导致渲染失败,可以更换手机或者网络环境测试。建议升级到穿山甲平台最新版本
-(void)nativeExpressRewardedVideoAdViewRenderFail:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd error:(NSError *)error {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsRenderFailedWithManager:error:adsType:)]) {
        [self.delegate sv_adsRenderFailedWithManager:self error:error adsType:SVAdsTypeBU];
    }
}

// 渲染成功回调。3100之后版本SDK，广告展示之后才会回调
-(void)nativeExpressRewardedVideoAdViewRenderSuccess:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsRenderSuccessWithManager:adsType:)]) {
        [self.delegate sv_adsRenderSuccessWithManager:self adsType:SVAdsTypeBU];
    }
}

//用户关闭广告时会触发此回调，注意：任何广告的关闭操作必须用户主动触发;
-(void)nativeExpressRewardedVideoAdDidClose:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsClosedWithManager:adsType:)]) {
        [self.delegate sv_adsClosedWithManager:self adsType:SVAdsTypeBU];
    }
}

// 点击回调方法
-(void)nativeExpressRewardedVideoAdDidClick:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsDidClick:adsType:)]) {
        [self.delegate sv_adsDidClick:self adsType:SVAdsTypeBU];
    }
}

// 跳过回调方法
-(void)nativeExpressRewardedVideoAdDidClickSkip:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsManager:videoSkipWithType:)]) {
        [self.delegate sv_adsManager:self videoSkipWithType:SVAdsTypeBU];
    }
}
//当视频广告播放完成或出现错误时调用此方法。
-(void)nativeExpressRewardedVideoAdDidPlayFinish:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    if (!error) {
        self.isEarned = YES;
    }
}

@end
