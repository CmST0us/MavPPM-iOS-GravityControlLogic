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

@interface MPMotionManager : NSObject
- (instancetype)initWithCMMotionManager:(CMMotionManager *)motionManager
                           workingQueue:(dispatch_queue_t)queue;
@end

NS_ASSUME_NONNULL_END
