//
//  SV_ABUFullRewardManager.m
//  AdsDemo
//
//  Created by  on 2021/9/17.
//

#import "SV_ABUFullRewardManager.h"

@interface SV_ABUFullRewardManager ()<ABUFullscreenVideoAdDelegate>

@property (nonatomic,strong)ABUFullscreenVideoAd *sv_ad;
@property (nonatomic,assign)BOOL isEarned;

@end

@implementation SV_ABUFullRewardManager

-(void)sv_requestAdWith:(NSString *)adId viewController:(UIViewController *)vc immediatelyShow:(BOOL)isImmediately {
    self.currentVC = vc;
    self.isPromptly = isImmediately;
    
    self.sv_ad = [[ABUFullscreenVideoAd alloc] initWithAdUnitID:adId];
    self.sv_ad.delegate = self;
    [self.sv_ad loadAdData];
}

-(void)sv_showFullVideoAd {
    if (!self.isPromptly && self.sv_adsLoaded) {
        BOOL flag = [self.sv_ad showAdFromRootViewController:self.currentVC];
        if (!flag) {
            NSLog(@"聚合 全屏视频广告未能展示出来");
            if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsShowFailedWithManager:error:adsType:)]) {
                [self.delegate sv_adsShowFailedWithManager:self error:nil adsType:SVAdsTypeABU];
            }
        }
    }
}

-(BOOL)sv_getRewardStatus {
    return self.isEarned;
}

#pragma mark - ABUFullscreenVideoAdDelegate
-(void)fullscreenVideoAdDidLoad:(ABUFullscreenVideoAd *)fullscreenVideoAd {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsLoadSuccessWithManager:adsType:)]) {
        [self.delegate sv_adsLoadSuccessWithManager:self adsType:SVAdsTypeABU];
    }
    if (self.isPromptly) {
        BOOL flag = [self.sv_ad showAdFromRootViewController:self.currentVC];
        if (!flag) {
            NSLog(@"聚合 全屏视频广告未能展示出来");
            if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsShowFailedWithManager:error:adsType:)]) {
                [self.delegate sv_adsShowFailedWithManager:self error:nil adsType:SVAdsTypeABU];
            }
        }
    }
    self.sv_adsLoaded = YES;
}

-(void)fullscreenVideoAdDidSkip:(ABUFullscreenVideoAd *)fullscreenVideoAd {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsManager:videoSkipWithType:)]) {
        [self.delegate sv_adsManager:self videoSkipWithType:SVAdsTypeABU];
    }
}

-(void)fullscreenVideoAdDidClick:(ABUFullscreenVideoAd *)fullscreenVideoAd {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsDidClick:adsType:)]) {
        [self.delegate sv_adsDidClick:self adsType:SVAdsTypeABU];
    }
}

-(void)fullscreenVideoAdDidClose:(ABUFullscreenVideoAd *)fullscreenVideoAd {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsClosedWithManager:adsType:)]) {
        [self.delegate sv_adsClosedWithManager:self adsType:SVAdsTypeABU];
    }
}

-(void)fullscreenVideoAdDidVisible:(ABUFullscreenVideoAd *)fullscreenVideoAd {
    
}

-(void)fullscreenVideoAd:(ABUFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *)error {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsLoadFailedWithManager:error:adsType:)]) {
        [self.delegate sv_adsLoadFailedWithManager:self error:error adsType:SVAdsTypeABU];
    }
}

-(void)fullscreenVideoAdDidShowFailed:(ABUFullscreenVideoAd *)fullscreenVideoAd error:(NSError *)error {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsShowFailedWithManager:error:adsType:)]) {
        [self.delegate sv_adsShowFailedWithManager:self error:error adsType:SVAdsTypeABU];
    }
}
//成功缓存时将调用此方法。
-(void)fullscreenVideoAdDidDownLoadVideo:(ABUFullscreenVideoAd *)fullscreenVideoAd {
    
}

- (void)fullscreenVideoAdDidPlayFinish:(ABUFullscreenVideoAd * _Nonnull)fullscreenVideoAd didFailWithError:(NSError *_Nullable)error {
    if (!error) {
        self.isEarned = YES;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsManager:videoPlayFinishWithType:)]) {
        [self.delegate sv_adsManager:self videoPlayFinishWithType:SVAdsTypeABU];
    }
}

@end
