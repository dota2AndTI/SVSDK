//
//  SV_BaseUtil.m
//  AdsDemo
//
//  Created by  on 2021/9/17.
//

#import "SV_BaseUtil.h"

@implementation SV_BaseUtil

+(instancetype)sv_shareUtil {
    static SV_BaseUtil *util = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        util = [[SV_BaseUtil alloc] init];
    });
    return util;
}

+(UIViewController *)sv_getCurrentViewController {
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1) {
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}

@end
