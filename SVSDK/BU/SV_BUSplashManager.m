//
//  SV_BUSplashManager.m
//  AdsDemo
//
//  Created by  on 2021/9/17.
//

#import "SV_BUSplashManager.h"

@interface SV_BUSplashManager ()<BUSplashAdDelegate>

@property (nonatomic,strong)BUSplashAdView *sv_adsView;

@property (nonatomic, assign) CFTimeInterval buSplashstartTime;

@end

@implementation SV_BUSplashManager

-(void)sv_adsShowWithSlotID:(NSString *)slotID frame:(CGRect)frame hideSkipBtn:(BOOL)isHide tolerateTimeout:(NSTimeInterval)tolerate currentVC:(UIViewController *)vc {
    self.sv_adsView = [[BUSplashAdView alloc] initWithSlotID:slotID frame:frame];
    // tolerateTimeout = CGFLOAT_MAX , The conversion time to milliseconds will be equal to 0
    self.sv_adsView.hideSkipButton = isHide;
    self.sv_adsView.tolerateTimeout = tolerate;
    self.sv_adsView.delegate = self;
    //optional
//    self.buSplashstartTime = CACurrentMediaTime();
    [self.sv_adsView loadAdData];
    [vc.view addSubview:self.sv_adsView];
}

-(void)splashAdDidLoad:(BUSplashAdView *)splashAd {
    NSLog(@"穿山甲 开屏广告请求成功");
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsLoadSuccessWithManager:adsType:)]) {
        [self.delegate sv_adsLoadSuccessWithManager:self adsType:SVAdsTypeBU];
    }
}
//请求失败的回调
-(void)splashAd:(BUSplashAdView *)splashAd didFailWithError:(NSError *)error {
    NSLog(@"穿山甲 开屏广告请求失败->%@",error);
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsLoadFailedWithManager:error:adsType:)]) {
        [self.delegate sv_adsLoadFailedWithManager:self error:error adsType:SVAdsTypeBU];
    }
}

-(void)splashAdDidClick:(BUSplashAdView *)splashAd {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsDidClick:adsType:)]) {
        [self.delegate sv_adsDidClick:self adsType:SVAdsTypeBU];
    }
}
// 用户点击跳过按钮时会触发此回调，可在此回调方法中处理用户点击跳转后的相关逻辑
-(void)splashAdDidClickSkip:(BUSplashAdView *)splashAd {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsManager:splashSkipWithType:)]) {
        [self.delegate sv_adsManager:self splashSkipWithType:SVAdsTypeBU];
    }
}
//SDK渲染开屏广告关闭回调，当用户点击广告时会直接触发此回调，建议在此回调方法中直接进行广告对象的移除操作
-(void)splashAdDidClose:(BUSplashAdView *)splashAd {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsClosedWithManager:adsType:)]) {
        [self.delegate sv_adsClosedWithManager:self adsType:SVAdsTypeBU];
        [self removeAds];
    }
}
// 倒计时为0时会触发此回调，如果客户端使用了此回调方法，建议在此回调方法中进行广告的移除操作
-(void)splashAdCountdownToZero:(BUSplashAdView *)splashAd {
    
}

-(void)removeAds {
    [self.sv_adsView removeFromSuperview];
    self.sv_adsView = nil;
}

-(void)dealloc {
    NSLog(@"穿山甲 开屏广告释放");
}

@end
