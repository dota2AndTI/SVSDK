//
//  SV_BUSplashManager.h
//  AdsDemo
//
//  Created by  on 2021/9/17.
//

#import "SV_AdsManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface SV_BUSplashManager : SV_AdsManager

-(void)sv_adsShowWithSlotID:(NSString *)slotID frame:(CGRect)frame hideSkipBtn:(BOOL)isHide tolerateTimeout:(NSTimeInterval)tolerate currentVC:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
