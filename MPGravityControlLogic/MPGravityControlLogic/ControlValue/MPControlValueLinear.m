//
//  MPControlValueLinear.m
//  MPGravityControlLogic
//
//  Created by CmST0us on 2019/2/10.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import "MPControlValueLinear.h"

@implementation MPControlValueLinear
- (instancetype)initWithOutputMax:(double)outMax
                        outputMin:(double)outMin
                         inputMax:(double)inMax
                         inputMin:(double)inMin {
    self = [super init];
    if (self) {
        _outputMax = outMax;
        _outputMin = outMin;
        _inputMax = inMax;
        _inputMin = inMin;
        // float 比较 0
        if (ABS(inMax - inMin) < FLT_EPSILON) {
            _k = 0;
        } else {
            _k = (outMax - outMin) / (inMax - inMin);
        }
        _b = outMax - _k * inMax;
    }
    return self;
}

- (double)calc:(double)x {
    x = MIN(_inputMax, x);
    x = MAX(_inputMin, x);
    return _k * x + _b;
}

@end
