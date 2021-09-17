//
//  SV_AdsManager.m
//  AdsDemo
//
//  Created by  on 2021/9/17.
//

#import "SV_AdsManager.h"
#import "SV_BaseUtil.h"

@implementation SV_AdsManager

+(void)sv_initWithType:(SVAdsType)type andAppIds:(NSDictionary *)idDict andABUExtraPlant:(void (^)(void))extraPlat {
    if (type && SVAdsTypeGoogle) {
        NSLog(@"google init");
        // 初始化 Google 广告的实现
    }
    if (type && SVAdsTypeBU) {
        NSLog(@"穿山甲 init");
        NSString *appId = idDict[@"BU"];
        [self sv_initBUAdsWithAppId:appId];
    }
    if (type && SVAdsTypeABU) {
        NSLog(@"聚合 init");
        NSString *appId = idDict[@"ABU"];
        [self sv_initABUWithAppId:appId andExtraPlant:extraPlat];
    }
}


+ (void)sv_initBUAdsWithAppId:(NSString *)appId{
    [BUAdSDKManager setAppID:appId];//@"5000546"
    [BUAdSDKManager setIsPaidApp:NO];
    [BUAdSDKManager setLoglevel:BUAdSDKLogLevelDebug];
}

+ (void)sv_initABUWithAppId:(NSString *)appId andExtraPlant:(void(^)(void))extraPlat{
    extraPlat();
    NSString *appid = appId;//@"5000546"
    // init app id
    [ABUAdSDKManager setAppID:appid];
}

-(UIViewController *)currentVC {
    if (!_currentVC) {
        _currentVC = [SV_BaseUtil sv_getCurrentViewController];
    }
    return _currentVC;
}


@end
