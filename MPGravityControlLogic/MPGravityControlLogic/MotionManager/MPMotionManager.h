//
//  MPMotionManager.h
//  MPGravityControlLogic
//
//  Created by CmST0us on 2019/2/10.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

NS_ASSUME_NONNULL_BEGIN
@class MPGravityControl;
@interface MPMotionManager : NSObject
@property (nonatomic, assign) NSTimeInterval dataUpdateInterval;
@property (nonatomic, assign) NSTimeInterval deviceMotionUpdateInterval;
@property (nonatomic, assign) NSTimeInterval accelerometerUpdateInterval;
@property (nonatomic, assign) NSTimeInterval gyroUpdateInterval;
@property (nonatomic, assign) NSTimeInterval magnetometerUpdateInterval;

- (instancetype)initWithCMMotionManager:(CMMotionManager *)motionManager
                              workQueue:(dispatch_queue_t)queue;

- (instancetype)initWithCMMotionManager:(CMMotionManager *)motionManager;

- (void)startUpdate;

- (void)stop;

- (void)addControl:(MPGravityControl *)control;
@end

NS_ASSUME_NONNULL_END
