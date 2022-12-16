//
//  EmbeddedView.m
//  ListViewExample
//
//  Created by zero on 2022/12/16.
//

#import "EmbeddedView.h"

@implementation EmbeddedView {
    CADisplayLink* _displayLink;
    CGFloat _tick;
    int64_t _viewId;
    UILabel *_label;
    int32_t _actual_refresh_rate;
}

- (instancetype)initWithFrame:(CGRect)frame
                       viewId:(int64_t)viewId {
    if (self = [super initWithFrame:frame]) {
        _viewId = viewId;
        _displayLink = [CADisplayLink displayLinkWithTarget:self
                                                   selector:@selector(onDisplayLink:)];
        double preferredFrameRate = 10.0;
        if (@available(iOS 15.0, *)) {
            _displayLink.preferredFrameRateRange = CAFrameRateRangeMake(preferredFrameRate, preferredFrameRate, preferredFrameRate);
        } else {
            _displayLink.preferredFramesPerSecond = preferredFrameRate;
        }
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop]
                           forMode:NSRunLoopCommonModes];

        _label = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 200, 40)];
        _label.text = [NSString stringWithFormat:@"UIView (id: %lld, preferredFrameRate: %f)", _viewId, preferredFrameRate];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.adjustsFontSizeToFitWidth = YES;
        _label.textColor = [UIColor whiteColor];

        self.backgroundColor = [UIColor greenColor];
        [self addSubview:_label];
    }

    return self;
}

- (void)onDisplayLink:(CADisplayLink*)link {
    if (CACurrentMediaTime() >= link.targetTimestamp) {
        return;
    }

    _actual_refresh_rate = round(1/(link.targetTimestamp - link.timestamp));
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    _tick = _tick + M_PI / 60;
    CGFloat green = (sin(_tick) + 1) / 2;

    [[UIColor colorWithRed:0.0
                     green:green
                      blue:0.0
                     alpha:1.0f] setFill];

    UIRectFill([self bounds]);
    _label.text = [NSString stringWithFormat:@"UIView (id: %lld, Actual FPS: %d)", _viewId, _actual_refresh_rate];
}

- (void)dealloc {
    if (_displayLink != nil) {
        [_displayLink invalidate];
        _displayLink = nil;
    }
}

@end
