//
//  SV_ABUSplashManager.m
//  AdsDemo
//
//  Created by  on 2021/9/17.
//

#import "SV_ABUSplashManager.h"

@interface SV_ABUSplashManager ()<ABUSplashAdDelegate>

@property (nonatomic,strong)ABUSplashAd *sv_ad;

@end

@implementation SV_ABUSplashManager

- (void)sv_requestAdWithAppId:(NSString *)appId splashId:(NSString *)splashId viewController:(UIViewController *)vc {
    self.currentVC = vc;
    
    self.sv_ad = [[ABUSplashAd alloc] initWithAdUnitID:splashId];
    self.sv_ad.delegate = self;
    self.sv_ad.rootViewController = vc;
    
    [self sv_loadUserDataWithAppId:appId splashId:splashId];
    [self.sv_ad loadAdData];
}

-(void)sv_loadUserDataWithAppId:(NSString *)appId splashId:(NSString *)splashId {
    //用于在广告位还在失败，采用传入的rit进行广告加载;该配置需要在load前设置
    ABUSplashUserData *userData = [[ABUSplashUserData alloc] init];
    userData.adnType = ABUAdnPangle;
    
    userData.appID = appId;     // 如果使用穿山甲兜底，请务必传入与MSDK初始化时一致的appID
    userData.rit = splashId;    // 开屏对应的代码位
    NSError *error = nil;
    
    // 在广告位配置拉取失败后，会使用传入的rit和appID兜底，进行广告加载，需要在创建manager时就调用该接口（仅支持穿山甲/MTG/GDT/百度）
    [self.sv_ad setUserData:userData error:&error];
    // ！！！如果有错误信息说明setUserData调用有误，需按错误提示重新设置
    if (error) {
        NSLog(@"log-error:%@",error);
    }
}

#pragma mark - ABUSplashAdDelegate
- (void)splashAdDidLoad:(ABUSplashAd *)splashAd {
    NSLog(@"%s",__func__);
    if (self.sv_ad) {
        UIWindow *window = self.currentVC.view.window;
        [self.sv_ad showInWindow:window];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsLoadSuccessWithManager:adsType:)]) {
        [self.delegate sv_adsLoadSuccessWithManager:self adsType:SVAdsTypeABU];
    }
}

- (void)splashAd:(ABUSplashAd *)splashAd didFailWithError:(NSError *)error {
    NSLog(@"%s-error:%@",__func__,error);
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsLoadFailedWithManager:error:adsType:)]) {
        [self.delegate sv_adsLoadFailedWithManager:self error:error adsType:SVAdsTypeABU];
    }
}

- (void)splashAdDidShowFailed:(ABUSplashAd *_Nonnull)splashAd error:(NSError *)error {
    NSLog(@"%s-聚合启动广告展示失败->%@",__func__,error);
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsShowFailedWithManager:error:adsType:)]) {
        [self.delegate sv_adsShowFailedWithManager:self error:error adsType:SVAdsTypeABU];
    }
}

-(void)splashAdDidClick:(ABUSplashAd *)splashAd {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsDidClick:adsType:)]) {
        [self.delegate sv_adsDidClick:self adsType:SVAdsTypeABU];
    }
}

- (void)splashAdDidClose:(ABUSplashAd *_Nonnull)splashAd {
    NSLog(@"%s",__func__);
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsClosedWithManager:adsType:)]) {
        [self.delegate sv_adsClosedWithManager:self adsType:SVAdsTypeABU];
    }
    if (self.sv_ad) {
        [self.sv_ad destoryAd];
    }
}

- (void)splashAdWillVisible:(ABUSplashAd *_Nonnull)splashAd {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsShowSuccessWithManager:adsType:)]) {
        [self.delegate sv_adsShowSuccessWithManager:self adsType:SVAdsTypeABU];
    }
    NSLog(@"%s",__func__);
}

@end
