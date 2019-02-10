//
//  MPGravityControl.h
//  MPGravityControlLogic
//
//  Created by CmST0us on 2019/2/10.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

NS_ASSUME_NONNULL_BEGIN

#define DEGToRAD(x) ((x) * M_PI / 180)
#define RADToDEG(x) ((x) * 180 / M_PI)

typedef NS_OPTIONS(NSUInteger, MPGravityControlType) {
    MPGravityControlTypeDeviceMotion = 1 << 0,
    MPGravityControlTypeAccelerometer = 1 << 1,
    MPGravityControlTypeGyro = 1 << 2,
    MPGravityControlTypeMagnetometer = 1 << 3,
};

@class MPGravityControl;
@protocol MPGravityControlDelegate <NSObject>
- (void)gravityControlDidUpdateData:(MPGravityControl *)control;
@end

@interface MPGravityControl : NSObject {
@protected
    CMLogItem *_logItem;
}
@property (nonatomic, weak) id<MPGravityControlDelegate> delegate;

- (MPGravityControlType)type;
- (void)updateData:(CMLogItem *)logItem;

// Subclass Override
- (void)onUpdataData;
@end

NS_ASSUME_NONNULL_END
