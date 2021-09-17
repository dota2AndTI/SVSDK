//
//  SV_BUInterstitialManager.m
//  AdsDemo
//
//  Created by  on 2021/9/17.
//

#import "SV_BUInterstitialManager.h"

@interface SV_BUInterstitialManager ()<BUNativeExpresInterstitialAdDelegate>

@property (nonatomic,strong)BUNativeExpressInterstitialAd *sv_ad;

@end

@implementation SV_BUInterstitialManager

-(void)sv_requestAdWithSlotID:(NSString *)idStr adSize:(CGSize)size currentVC:(UIViewController *)vc immediatelyShow:(BOOL)isImmediately {
    self.currentVC = vc;
    self.isPromptly = isImmediately;
    self.sv_ad = [[BUNativeExpressInterstitialAd alloc] initWithSlotID:idStr adSize:size];
    self.sv_ad.delegate = self;
    [self.sv_ad loadAdData];
}

-(void)sv_showInterstitialAd {
    if (self.sv_adsLoaded && !self.isPromptly) {
        BOOL flag = [self.sv_ad showAdFromRootViewController:self.currentVC];
        if (!flag) {//展示失败
            if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsShowFailedWithManager:error:adsType:)]) {
                [self.delegate sv_adsShowFailedWithManager:self error:nil adsType:SVAdsTypeBU];
            }
        }
    }
}

#pragma mark - BUNativeExpresInterstitialAdDelegate
// 广告素材物料加载成功
-(void)nativeExpresInterstitialAdDidLoad:(BUNativeExpressInterstitialAd *)interstitialAd {
    NSLog(@"穿山甲 插屏广告加载成功");
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsLoadSuccessWithManager:adsType:)]) {
        [self.delegate sv_adsLoadSuccessWithManager:self adsType:SVAdsTypeBU];
    }
}

//返回的错误码(error)表示广告加载失败的原因，
-(void)nativeExpresInterstitialAd:(BUNativeExpressInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
    NSLog(@"穿山甲 插屏广告加载失败->%@",error);
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsLoadFailedWithManager:error:adsType:)]) {
        [self.delegate sv_adsLoadFailedWithManager:self error:error adsType:SVAdsTypeBU];
    }
}

// 渲染成功回调
-(void)nativeExpresInterstitialAdRenderSuccess:(BUNativeExpressInterstitialAd *)interstitialAd {
    NSLog(@"穿山甲 插屏广告渲染成功");
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsRenderSuccessWithManager:adsType:)]) {
        [self.delegate sv_adsRenderSuccessWithManager:self adsType:SVAdsTypeBU];
    }
    if (self.isPromptly) {
        BOOL flag = [interstitialAd showAdFromRootViewController:self.currentVC];
        if (!flag) {//展示失败
            if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsShowFailedWithManager:error:adsType:)]) {
                [self.delegate sv_adsShowFailedWithManager:self error:nil adsType:SVAdsTypeBU];
            }
        }
    }
    self.sv_adsLoaded = YES;
}
// 渲染失败回调
- (void)nativeExpresInterstitialAdRenderFail:(BUNativeExpressInterstitialAd *)interstitialAd error:(NSError * __nullable)error {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsRenderFailedWithManager:error:adsType:)]) {
        [self.delegate sv_adsRenderFailedWithManager:self error:error adsType:SVAdsTypeBU];
    }
}

- (void)nativeExpresInterstitialAdDidClick:(BUNativeExpressInterstitialAd *)interstitialAd {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsClosedWithManager:adsType:)]) {
        [self.delegate sv_adsClosedWithManager:self adsType:SVAdsTypeBU];
    }
}

- (void)nativeExpresInterstitialAdDidClose:(BUNativeExpressInterstitialAd *)interstitialAd {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsClosedWithManager:adsType:)]) {
        [self.delegate sv_adsClosedWithManager:self adsType:SVAdsTypeBU];
    }
}

@end
