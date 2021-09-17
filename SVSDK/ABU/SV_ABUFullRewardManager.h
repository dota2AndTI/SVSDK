//
//  SV_ABUFullRewardManager.h
//  AdsDemo
//
//  Created by  on 2021/9/17.
//

#import "SV_AdsManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface SV_ABUFullRewardManager : SV_AdsManager

-(void)sv_requestAdWith:(NSString *)adId viewController:(UIViewController *)vc immediatelyShow:(BOOL) isImmediately;

-(void)sv_showFullVideoAd;

-(BOOL)sv_getRewardStatus;

@end

NS_ASSUME_NONNULL_END
