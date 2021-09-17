//
//  SV_FullRewardManager.h
//  AdsDemo
//
//  Created by  on 2021/9/17.
//

#import "SV_AdsManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface SV_BUFullRewardManager : SV_AdsManager

-(void)sv_requestAdsWithSlotID:(NSString *)idStr currentVC:(UIViewController *)vc immediatelyShow:(BOOL) isImmediately;
-(void)sv_showAds;
-(BOOL)sv_earnRewardStatus;

@end

NS_ASSUME_NONNULL_END
