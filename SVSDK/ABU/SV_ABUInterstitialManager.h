//
//  SV_ABUInterstitialManager.h
//  AdsDemo
//
//  Created by  on 2021/9/17.
//

#import "SV_AdsManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface SV_ABUInterstitialManager : SV_AdsManager

-(void)sv_requestInterstitialAdWith:(NSString *)adId expectSize:(CGSize)size viewController:(UIViewController *)vc immediatelyShow:(BOOL) isImmediately;

-(void)sv_showInterstitialAd;

@end

NS_ASSUME_NONNULL_END
