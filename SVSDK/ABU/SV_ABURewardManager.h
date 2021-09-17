//
//  SV_ABURewardManager.h
//  AdsDemo
//
//  Created by  on 2021/9/17.
//

#import "SV_AdsManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface SV_ABURewardManager : SV_AdsManager

-(void)sv_requestRewardAdWith:(NSString *)adId viewController:(UIViewController *)vc immediatelyShow:(BOOL) isImmediately;

-(void)sv_showRewardAdWith:(NSString *)adId;

-(BOOL)sv_getRewardStatus;

@end

NS_ASSUME_NONNULL_END
