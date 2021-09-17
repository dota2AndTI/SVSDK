//
//  SV_AdsManager.h
//  AdsDemo
//
//  Created by  on 2021/9/17.
//

#import <Foundation/Foundation.h>

#import <GoogleMobileAds/GoogleMobileAds.h>
#import <BUAdSDK/BUAdSDK.h>
#import <ABUAdSDK/ABUAdSDK.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum SVAdsType {
    SVAdsTypeGoogle = 1 << 0, // 0  0
    SVAdsTypeBU = 1 << 1, // 1  1
    SVAdsTypeABU = 1 << 2 // 2  10 转换成 10进制  2
} SVAdsType;

@class SV_AdsManager;
@protocol SV_AdsManagerDelegate <NSObject>

@optional
//Common
-(void)sv_adsLoadSuccessWithManager:(SV_AdsManager *)manager adsType:(SVAdsType)type;
-(void)sv_adsLoadFailedWithManager:(SV_AdsManager *)manager error:(NSError *)error adsType:(SVAdsType)type;
-(void)sv_adsClosedWithManager:(SV_AdsManager *)manager adsType:(SVAdsType)type;
-(void)sv_adsDidClick:(SV_AdsManager*)manager adsType:(SVAdsType)type;

-(void)sv_adsRenderSuccessWithManager:(SV_AdsManager *)manager adsType:(SVAdsType)type;
-(void)sv_adsRenderFailedWithManager:(SV_AdsManager *)manager error:(NSError *)error adsType:(SVAdsType)type;

-(void)sv_adsShowSuccessWithManager:(SV_AdsManager *)manager adsType:(SVAdsType)type;
-(void)sv_adsShowFailedWithManager:(SV_AdsManager *)manager error:(NSError *)error adsType:(SVAdsType)type;

// 激励 全屏激励
-(void)sv_adsManager:(SV_AdsManager *)manager videoPlayFinishWithType:(SVAdsType)type;
-(void)sv_adsManager:(SV_AdsManager *)manager videoSkipWithType:(SVAdsType)type;
-(void)sv_adsManager:(SV_AdsManager *)manager videoDownloadWithType:(SVAdsType)type;


// 插屏

// 信息流 目前仅适用于穿山甲
-(void)sv_adsManager:(SV_AdsManager *)manager expressLoadSuccess:(NSArray<__kindof BUNativeExpressAdView *> *)views;
-(void)sv_adsManager:(SV_AdsManager *)manager expressLoadFailed:(NSError *)error;
-(void)sv_adsManager:(SV_AdsManager *)manager expressDislikeWithView:(BUNativeExpressAdView *)expressAdView;

// 开屏
-(void)sv_adsManager:(SV_AdsManager *)manager splashSkipWithType:(SVAdsType)type;

// banner

@end

@interface SV_AdsManager : NSObject

@property (nonatomic,weak) id<SV_AdsManagerDelegate> delegate;
@property (nonatomic,strong)UIViewController *currentVC;
@property (nonatomic,assign)BOOL isPromptly;
@property (nonatomic,assign)BOOL sv_adsLoaded;// yes:加载成功 no: 加载失败


/*
// type 类型可写多个
 idDict 是字典 @{@"google":@"***",@"BU",@"***",@"ABU",@"***",nil}
 extraPlat 用于聚合添加 Google 广点通 百度 快手等平台的广告适配
 */
+ (void) sv_initWithType:(SVAdsType)type andAppIds:(NSDictionary *)idDict andABUExtraPlant:(void(^)(void))extraPlat;

@end

NS_ASSUME_NONNULL_END
