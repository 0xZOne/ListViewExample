//
//  ViewController.m
//  ListViewExample
//
//  Created by zero on 2022/12/16.
//

#import "ViewController.h"
#import "EmbeddedView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CGFloat subviewHeight = (CGFloat)120;
    CGFloat currentViewOffset = (CGFloat)0;
    
    CGFloat contentWidth = self.scrollView.bounds.size.width;
    CGFloat contentHeight = subviewHeight * 20;
    self.scrollView.contentSize = CGSizeMake(contentWidth, contentHeight);
    
    int index = 0;
    while (currentViewOffset < contentHeight) {
        CGRect frame = CGRectInset(CGRectMake(0, currentViewOffset, contentWidth, subviewHeight), 5, 5);
        CGFloat hue = currentViewOffset/contentHeight;
        UIView *subview = [[EmbeddedView alloc]initWithFrame:frame
                                                      viewId:index++];
        subview.backgroundColor = [UIColor colorWithHue:hue saturation:1 brightness:1 alpha:1];
        [self.scrollView addSubview:subview];
        
        currentViewOffset += subviewHeight;
    }
}


@end
