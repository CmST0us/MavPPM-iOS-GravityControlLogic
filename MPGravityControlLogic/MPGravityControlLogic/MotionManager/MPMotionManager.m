//
//  MPMotionManager.m
//  MPGravityControlLogic
//
//  Created by CmST0us on 2019/2/10.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "MPMotionManager.h"
#import "MPGravityControl.h"

#define kMPMotionManagerMaxUpdateInterval 0.1

@interface MPMotionManager ()
@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, strong) dispatch_queue_t workQueue;
@property (nonatomic, strong) dispatch_source_t updateTimer;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSMutableArray<MPGravityControl *> *> *mutableControls;
@end

@implementation MPMotionManager

- (instancetype)initWithCMMotionManager:(CMMotionManager *)motionManager workQueue:(dispatch_queue_t)queue {
    self = [super init];
    if (self) {
        _motionManager = motionManager;
        _workQueue = queue;
        _dataUpdateInterval = kMPMotionManagerMaxUpdateInterval;
        _deviceMotionUpdateInterval = kMPMotionManagerMaxUpdateInterval;
        _gyroUpdateInterval = kMPMotionManagerMaxUpdateInterval;
        _magnetometerUpdateInterval = kMPMotionManagerMaxUpdateInterval;
        _accelerometerUpdateInterval = kMPMotionManagerMaxUpdateInterval;
    }
    return self;
}

- (instancetype)initWithCMMotionManager:(CMMotionManager *)motionManager {
    dispatch_queue_t queue = dispatch_queue_create("com.MPGravityControlLogic.MPMotionManager.defaultWorkQueue", DISPATCH_QUEUE_SERIAL);
    return [self initWithCMMotionManager:motionManager workQueue:queue];
}

- (void)dealloc {
    [self stop];
}

- (NSMutableDictionary<NSNumber *,NSMutableArray<MPGravityControl *> *> *)mutableControls {
    if (_mutableControls != nil) {
        return _mutableControls;
    }
    _mutableControls = [[NSMutableDictionary alloc] init];
    return _mutableControls;
}
- (dispatch_source_t)updateTimer {
    if (_updateTimer != nil) {
        return _updateTimer;
    }
    __weak typeof(self) weakSelf = self;
    _updateTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, self.workQueue);
    dispatch_source_set_timer(_updateTimer, DISPATCH_TIME_NOW, self.dataUpdateInterval * NSEC_PER_SEC, 1 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(_updateTimer, ^{
        [weakSelf updateData];
    });
    return _updateTimer;
}

- (void)setDeviceMotionUpdateInterval:(NSTimeInterval)deviceMotionUpdateInterval {
    _deviceMotionUpdateInterval = deviceMotionUpdateInterval;
    _dataUpdateInterval = MIN(_dataUpdateInterval, deviceMotionUpdateInterval);
}

- (void)setAccelerometerUpdateInterval:(NSTimeInterval)accelerometerUpdateInterval {
    _accelerometerUpdateInterval = accelerometerUpdateInterval;
    _dataUpdateInterval = MIN(_dataUpdateInterval, accelerometerUpdateInterval);
}

- (void)setGyroUpdateInterval:(NSTimeInterval)gyroUpdateInterval {
    _gyroUpdateInterval = gyroUpdateInterval;
    _dataUpdateInterval = MIN(_dataUpdateInterval, gyroUpdateInterval);
}

- (void)setMagnetometerUpdateInterval:(NSTimeInterval)magnetometerUpdateInterval {
    _magnetometerUpdateInterval = magnetometerUpdateInterval;
    _dataUpdateInterval = MIN(_dataUpdateInterval, magnetometerUpdateInterval);
}

- (void)startUpdate {
    for (NSNumber *type in [self.mutableControls allKeys]) {
        NSMutableArray *controls = self.mutableControls[type];
        if (controls != nil) {
            if ([type unsignedIntegerValue] & MPGravityControlTypeDeviceMotion) {
                if (self.motionManager.deviceMotionAvailable) {
                    self.motionManager.deviceMotionUpdateInterval = self.deviceMotionUpdateInterval;
                    [self.motionManager startDeviceMotionUpdates];
                }
            }
            if ([type unsignedIntegerValue] & MPGravityControlTypeAccelerometer) {
                if (self.motionManager.accelerometerAvailable) {
                    self.motionManager.accelerometerUpdateInterval = self.accelerometerUpdateInterval;
                    [self.motionManager startAccelerometerUpdates];
                }
            }
            if ([type unsignedIntegerValue] & MPGravityControlTypeGyro) {
                if (self.motionManager.gyroAvailable) {
                    self.motionManager.gyroUpdateInterval = self.gyroUpdateInterval;
                    [self.motionManager startGyroUpdates];
                }
            }
            if ([type unsignedIntegerValue] & MPGravityControlTypeMagnetometer) {
                if (self.motionManager.magnetometerAvailable) {
                    self.motionManager.magnetometerUpdateInterval = self.magnetometerUpdateInterval;
                    [self.motionManager startMagnetometerUpdates];
                }
            }
        }
    }
    
    // start time interval
    dispatch_resume(self.updateTimer);
}

- (void)stopDataUpdate {
    dispatch_sync(self.workQueue, ^{
        dispatch_source_cancel(self.updateTimer);
        self.updateTimer = nil;
    });
}

- (void)stopMotionManager {
    dispatch_sync(self.workQueue, ^{
        [self.motionManager stopGyroUpdates];
        [self.motionManager stopDeviceMotionUpdates];
        [self.motionManager stopMagnetometerUpdates];
        [self.motionManager stopAccelerometerUpdates];
    });
}

- (void)stop {
    [self stopDataUpdate];
    [self stopMotionManager];
    dispatch_sync(self.workQueue, ^{
        [self.mutableControls removeAllObjects];
    });
}

- (void)addControl:(MPGravityControl *)control {
    MPGravityControlType type = control.type;
    NSNumber *typeNumber = [NSNumber numberWithUnsignedInteger:type];
    NSMutableArray *controls = self.mutableControls[typeNumber];
    if (controls == nil) {
        controls = [[NSMutableArray alloc] init];
        [self.mutableControls setObject:controls forKey:typeNumber];
    }
    [controls addObject:control];
}

- (void)updateData {
    for (NSNumber *type in [self.mutableControls allKeys]) {
        NSMutableArray *controls = self.mutableControls[type];
        if (controls != nil) {
            for (MPGravityControl *control in controls) {
                if ([type unsignedIntegerValue] & MPGravityControlTypeDeviceMotion) {
                    if (self.motionManager.deviceMotionActive) {
                        [control updateData:self.motionManager.deviceMotion];
                    }
                }
                if ([type unsignedIntegerValue] & MPGravityControlTypeAccelerometer) {
                    if (self.motionManager.deviceMotionActive) {
                        [control updateData:self.motionManager.accelerometerData];
                    }
                }
                if ([type unsignedIntegerValue] & MPGravityControlTypeGyro) {
                    if (self.motionManager.deviceMotionActive) {
                        [control updateData:self.motionManager.gyroData];
                    }
                }
                if ([type unsignedIntegerValue] & MPGravityControlTypeMagnetometer) {
                    if (self.motionManager.deviceMotionActive) {
                        [control updateData:self.motionManager.magnetometerData];
                    }
                }
            }
        }
    }
}

@end
