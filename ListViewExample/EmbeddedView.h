//
//  EmbeddedView.h
//  ListViewExample
//
//  Created by zero on 2022/12/16.
//

#ifndef EmbeddedView_h
#define EmbeddedView_h

#include <UIKit/UIKit.h>

// A UIView that is used as the embedded UIViews.
@interface EmbeddedView : UIView
- (instancetype _Nonnull)initWithFrame:(CGRect)frame
                                viewId:(int64_t)viewId;

@end

#endif /* EmbeddedView_h */
