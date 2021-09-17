//
//  SV_GADSplashManager.h
//  AdsDemo
//
//  Created by  on 2021/9/17.
//

#import "SV_AdsManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface SV_GADSplashManager : SV_AdsManager

-(void)sv_showAdWithUnitID:(NSString *)unitID viewController:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
