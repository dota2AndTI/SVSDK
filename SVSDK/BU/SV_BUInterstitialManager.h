//
//  SV_BUInterstitialManager.h
//  AdsDemo
//
//  Created by  on 2021/9/17.
//

#import "SV_AdsManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface SV_BUInterstitialManager : SV_AdsManager

-(void)sv_requestAdWithSlotID:(NSString *)idStr adSize:(CGSize)size currentVC:(UIViewController *)vc immediatelyShow:(BOOL) isImmediately;


-(void)sv_showInterstitialAd;

@end

NS_ASSUME_NONNULL_END
