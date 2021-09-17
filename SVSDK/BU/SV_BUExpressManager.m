//
//  SV_BUExpressManager.m
//  AdsDemo
//
//  Created by  on 2021/9/17.
//

#import "SV_BUExpressManager.h"

@interface SV_BUExpressManager ()<BUNativeExpressAdViewDelegate>

@property (nonatomic,strong)BUNativeExpressAdManager *sv_ad;

@property (nonatomic,strong)NSMutableArray<BUNativeExpressAdView *> *sv_adViews;

@end

@implementation SV_BUExpressManager

-(NSMutableArray<BUNativeExpressAdView *> *)sv_adViews {
    if (!_sv_adViews) {
        _sv_adViews = [NSMutableArray arrayWithCapacity:3];
    }
    return _sv_adViews;
}

-(void)sv_requesAdWithSlotID:(NSString *)idStr adSize:(CGSize)size count:(NSInteger)count currentVC:(UIViewController *)vc immediatelyShow:(BOOL)isImmediately {
    self.currentVC = vc;
    BUAdSlot *slot1 = [[BUAdSlot alloc] init];
    slot1.ID = idStr;
    slot1.AdType = BUAdSlotAdTypeFeed;
    BUSize *imgSize = [BUSize sizeBy:BUProposalSize_Feed228_150];
    slot1.imgSize = imgSize;
    slot1.position = BUAdSlotPositionFeed;
    // self.nativeExpressAdManager可以重用
    self.sv_ad= [[BUNativeExpressAdManager alloc] initWithSlot:slot1 adSize:size];
    self.sv_ad.delegate = self;
    [self.sv_ad loadAdDataWithCount:count];
}

-(NSMutableArray *)sv_getExpressAdWithSlotID:(NSString *)slotID {
    return self.sv_adViews;
}

#pragma mark - BUNativeExpressAdViewDelegate
//广告视图加载成功
-(void)nativeExpressAdSuccessToLoad:(BUNativeExpressAdManager *)nativeExpressAdManager views:(NSArray<__kindof BUNativeExpressAdView *> *)views {
    self.sv_adViews = [views mutableCopy];
//    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsLoadSuccessWithManager:adsType:)]) {
//        [self.delegate sv_adsLoadSuccessWithManager:self adsType:SVAdsTypeBU];
//    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsManager:expressLoadSuccess:)]) {
        [self.delegate sv_adsManager:self expressLoadSuccess:views];
    }
}
// 返回的错误码(error)表示广告加载失败的原因
-(void)nativeExpressAdFailToLoad:(BUNativeExpressAdManager *)nativeExpressAdManager error:(NSError *)error {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsLoadFailedWithManager:error:adsType:)]) {
        [self.delegate sv_adsLoadFailedWithManager:self error:error adsType:SVAdsTypeBU];
    }
}
// 渲染成功
-(void)nativeExpressAdViewRenderSuccess:(BUNativeExpressAdView *)nativeExpressAdView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsRenderSuccessWithManager:adsType:)]) {
        [self.delegate sv_adsLoadSuccessWithManager:self adsType:SVAdsTypeBU];
    }
}

- (void)nativeExpressAdViewRenderFail:(BUNativeExpressAdView *)nativeExpressAdView error:(NSError *_Nullable)error {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsRenderFailedWithManager:error:adsType:)]) {
        [self.delegate sv_adsLoadFailedWithManager:self error:error adsType:SVAdsTypeBU];
    }
}


// 穿山甲会主动关闭掉广告，广告移除后需要开发者对界面进行适配
-(void)nativeExpressAdViewDidRemoved:(BUNativeExpressAdView *)nativeExpressAdView {
    [self.sv_adViews removeObject:nativeExpressAdView];
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsManager:expressDislikeWithView:)]) {
        [self.delegate sv_adsManager:self expressDislikeWithView:nativeExpressAdView];
    }
}
//点击了不喜欢 广告移除后需要开发者对界面进行适配
-(void)nativeExpressAdView:(BUNativeExpressAdView *)nativeExpressAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterWords {
    [self.sv_adViews removeObject:nativeExpressAdView];
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsManager:expressDislikeWithView:)]) {
        [self.delegate sv_adsManager:self expressDislikeWithView:nativeExpressAdView];
    }
}


@end
