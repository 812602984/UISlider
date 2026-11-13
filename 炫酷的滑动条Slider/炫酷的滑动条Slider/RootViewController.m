//
//  RootViewController.m
//  炫酷的滑动条Slider
//
//  Created by qianfeng on 15-4-20.
//  Copyright (c) 2015年 psw. All rights reserved.
//

#import "RootViewController.h"
#define kClearImageViewTag 100

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testUISlider];
}

-(void)testUISlider
{
    CGRect frame = CGRectMake(20, 220, self.view.frame.size.width-40, 25);
    UISlider *slider = [[UISlider alloc] initWithFrame:frame]; // Default is 0.0-1.0
    UIImage *minimumImage = [UIImage imageNamed:@"slider_minimum.png"];
    UIImage *maximumImage = [UIImage imageNamed:@"slider_maximum.png"];
    UIImage *clearImage = [UIImage imageNamed:@"clear.png"];
    
    UIImageView *minimumImageView = [[UIImageView alloc] initWithFrame:slider.frame];
    minimumImageView.backgroundColor = [UIColor colorWithPatternImage:minimumImage];
    [self.view addSubview:minimumImageView];
    [minimumImageView release];
    UIImageView *maximumImageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 10, slider.frame.size.height)];
    maximumImageView.backgroundColor = [UIColor colorWithPatternImage:maximumImage];
    maximumImageView.tag = kClearImageViewTag;
    [self.view addSubview:maximumImageView];
    [maximumImageView release];
    
    [slider setMinimumTrackImage:clearImage forState:UIControlStateNormal];
    [slider setMaximumTrackImage:clearImage forState:UIControlStateNormal];
    [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
}

- (void)sliderAction:(UISlider *)slider {
    UIImageView *imageView = (id)[self.view viewWithTag:kClearImageViewTag];
    imageView.frame = CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y, slider.frame.size.width*slider.value, imageView.frame.size.height);
    NSLog(@"%lf", slider.value);
}


@end
